from enum import StrEnum

from jinja2 import Environment, PackageLoader, select_autoescape
from .classes import ERDDAP


class Mode(StrEnum):
    """Enum used to select the mode of the line ending conversion."""

    Win2Unix = "Win2Unix"
    Unix2Win = "Unix2Win"


def change_line_ending(filename: str, mode: Mode = Mode.Win2Unix):
    """Convert the line ending of the given file using the given mode.

    Args:
        filename (str): File to convert the line ending.
        mode (Mode, optional): Type of conversion, windows to unix or vice versa. Defaults to Mode.Win2Unix.
    """
    WINDOWS_LINE_ENDING = b"\r\n"
    UNIX_LINE_ENDING = b"\n"

    # Open given file
    with open(filename, "rb") as open_file:
        content = open_file.read()

    if mode == Mode.Win2Unix:
        # Windows to Unix
        content = content.replace(WINDOWS_LINE_ENDING, UNIX_LINE_ENDING)

    elif mode == Mode.Unix2Win:
        # Unix to Windows
        content = content.replace(UNIX_LINE_ENDING, WINDOWS_LINE_ENDING)

    # Save converted file
    with open(filename, "wb") as open_file:
        open_file.write(content)


def obj2sqlscript(erddap: ERDDAP):
    output = []

    # Render the template
    env = Environment(loader=PackageLoader("erddapcfg"), autoescape=select_autoescape())
    template = env.get_template("db_insert.j2")
    output.append(
        template.render(
            params=erddap.params,
            datasets=erddap.datasets,
            dataset_params=[
                {"name": param.name, "value": param.value, "datasetID": dataset.datasetID}
                for dataset in erddap.datasets
                for param in dataset.params
            ],
            dataset_attributes=[
                {
                    "name": attribute.name,
                    "type": attribute.type,
                    "text": attribute.text,
                    "datasetID": dataset.datasetID,
                }
                for dataset in erddap.datasets
                for attribute in dataset.attributes
            ],
            dataset_source_attributes=[
                {
                    "name": attribute.name,
                    "type": attribute.type,
                    "text": attribute.text,
                    "datasetID": dataset.datasetID,
                }
                for dataset in erddap.datasets
                for attribute in dataset.source_attributes
            ],
            variables=[
                {
                    "tag": variable.tag,
                    "sourceName": variable.sourceName,
                    "destinationName": variable.destinationName,
                    "dataType": variable.dataType,
                    "datasetID": dataset.datasetID,
                }
                for dataset in erddap.datasets
                for variable in dataset.variables
            ],
            variable_attributes=[
                {
                    "name": attribute.name,
                    "type": attribute.type,
                    "text": attribute.text,
                    "destinationName": variable.destinationName,
                    "datasetID": dataset.datasetID,
                }
                for dataset in erddap.datasets
                for variable in dataset.variables
                for attribute in variable.attributes
            ],
            variable_source_attributes=[
                {
                    "name": attribute.name,
                    "type": attribute.type,
                    "text": attribute.text,
                    "destinationName": variable.destinationName,
                    "datasetID": dataset.datasetID,
                }
                for dataset in erddap.datasets
                for variable in dataset.variables
                for attribute in variable.source_attributes
            ],
            dataset_children=erddap.parent_child,
        )
    )

    return "".join(output)
