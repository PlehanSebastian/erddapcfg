import os
import sqlite3

from jinja2 import Environment, PackageLoader, select_autoescape

from .sql_script import SQL_CREATE
from .xml_to_obj import xml2obj


def xml2db(db_filename: str, xml_filename: str, parse_source_attributes: bool = False, save_only_sql: bool = False):
    """Convert a XML datasets ERDDAP configuration to a DB sqlite.

    Args:
        db_filename (str): database sqlite filename.
        xml_filename (str): xml filename.
        parse_source_Attributes (bool, optional): Flag to enable the parsing of the sourceAttributes nodes. Defaults to False.
    """

    erddap = xml2obj(xml_filename=xml_filename, parse_source_attributes=parse_source_attributes)

    if not save_only_sql:
        # Create empty database file
        if os.path.isfile(db_filename):
            os.remove(db_filename)
        connection = sqlite3.connect(db_filename)
        cursor = connection.cursor()

        # Create empty tables if database
        cursor.executescript(SQL_CREATE)

    # Render the template
    env = Environment(loader=PackageLoader("erddapcfg"), autoescape=select_autoescape())
    template = env.get_template("db_insert.j2")
    output = template.render(erddap=erddap)

    # Insert dataset children in db
    template = env.get_template("db_insert_dataset_children.j2")
    output += template.render(parent_child=erddap.parent_child)

    if save_only_sql:
        with open(db_filename, "w", encoding="utf-8") as f:
            f.write(output)
    else:
        # Execute the inserts in db
        cursor.executescript(output)

        # Save db
        connection.commit()
        connection.close()
