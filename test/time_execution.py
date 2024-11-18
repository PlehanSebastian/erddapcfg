import os
import time

from erddapcfg import xml2db, db2xml, xml2sql


NUMBER_OF_SIMULATION: int = 50

test_report = []

xml_filename: str = "datasets.xml"
db_filename: str = "database.db"
sql_filename: str = "database.sql"

test_report_filename = f".test_report_{os.path.basename(__file__)}.txt"


def simulation(func):
    def wrapper_function(*args, **kwargs):
        t0 = time.time()
        for _ in range(NUMBER_OF_SIMULATION):
            func(*args, **kwargs)
        t1 = time.time()
        test_report.append(f"""
    total   : {t1 - t0:<20} seconds for {NUMBER_OF_SIMULATION} simulations
    average : {(t1 - t0) / NUMBER_OF_SIMULATION:<20} seconds for single simulation
""")

    return wrapper_function


# -------------------------------------------------------------------
# Test time execution of xml2db function
# -------------------------------------------------------------------
test_report.append("xml2db")
simulation(lambda: xml2db(xml_filename=xml_filename, db_filename=db_filename))()


# -------------------------------------------------------------------
# Test time execution of xml2db function in unsafe mode
# -------------------------------------------------------------------
test_report.append("xml2db [unsafe]")
simulation(lambda: xml2db(xml_filename=xml_filename, db_filename=db_filename, unsafe=True))()


# -------------------------------------------------------------------
# Test time execution of xml2sql function
# -------------------------------------------------------------------
test_report.append("xml2sql")
simulation(lambda: xml2sql(xml_filename=xml_filename, sql_filename=sql_filename))()


# -------------------------------------------------------------------
# Test time execution of db2xml function
# -------------------------------------------------------------------
test_report.append("db2xml")
simulation(lambda: db2xml(xml_filename=xml_filename, db_filename=db_filename))()


# -------------------------------------------------------------------
# Save test report
# -------------------------------------------------------------------
with open(test_report_filename, "w", encoding="utf-8") as f:
    f.write("\n".join(test_report))
