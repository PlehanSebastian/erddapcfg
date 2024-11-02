from jinja2 import Environment, PackageLoader, select_autoescape
from .classes import ERDDAP


def obj2sqlscript(erddap: ERDDAP):
    """Convert an ERDDAP object into a sql script INSERT script, using the jinja2 template engine.

    Args:
        erddap (ERDDAP): ERDDAP object to convert into a sql script.
    """
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
