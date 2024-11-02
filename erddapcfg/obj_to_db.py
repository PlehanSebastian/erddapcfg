import os
import sqlite3

from .classes import ERDDAP
from .sql_script import SQL_CREATE
from .utils import obj2sqlscript


def obj2db(erddap: ERDDAP, db_filename: str, parse_source_attributes: bool = False) -> None:
    """Convert a XML datasets ERDDAP configuration to a DB sqlite.

    Args:
        erddap (ERDDAP): python object to convert.
        db_filename (str): database sqlite filename.
        parse_source_Attributes (bool, optional): Flag to enable the parsing of the sourceAttributes nodes. Defaults to False.
    """

    sql_script = obj2sqlscript(erddap)

    # Create empty database file
    if os.path.isfile(db_filename):
        os.remove(db_filename)
    connection = sqlite3.connect(db_filename)
    cursor = connection.cursor()

    # Create empty tables if database
    cursor.executescript(SQL_CREATE)

    # Execute the inserts in db
    cursor.executescript(sql_script)

    # Save db
    connection.commit()
    connection.close()
