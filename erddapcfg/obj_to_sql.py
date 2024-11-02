from .classes import ERDDAP
from .sql_script import SQL_CREATE
from .utils import obj2sqlscript


def obj2sql(erddap: ERDDAP, sql_filename: str, parse_source_attributes: bool = False) -> None:
    """Convert a XML datasets ERDDAP configuration to a sql script.

    Args:
        erddap (ERDDAP): python object to convert.
        sql_filename (str): sql filename.
        parse_source_Attributes (bool, optional): Flag to enable the parsing of the sourceAttributes nodes. Defaults to False.
    """

    output = obj2sqlscript(erddap)

    # Save sql
    with open(sql_filename, "w", encoding="utf-8") as f:
        f.write(SQL_CREATE)
        f.write(output)
