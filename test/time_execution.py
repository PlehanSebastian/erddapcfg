import os
import time

from erddapcfg import xml2db, db2xml, xml2sql


NUMBER_OF_EMULATION: int = 50

test_report = []


def emulate_execution(func):
    def wrapper_function(*args, **kwargs):
        t0 = time.time()
        for _ in range(NUMBER_OF_EMULATION):
            func(*args, **kwargs)
        t1 = time.time()
        test_report.append(f"""
    total   : {t1 - t0:<20} seconds for {NUMBER_OF_EMULATION} emulations
    average : {(t1 - t0) / NUMBER_OF_EMULATION:<20} seconds for single emulation
""")

    return wrapper_function


# -------------------------------------------------------------------
# Test time execution of xml2db function
# -------------------------------------------------------------------
test_report.append("xml2db")
emulate_execution(lambda: xml2db(xml_filename="datasets.xml", db_filename="database.db"))()


# -------------------------------------------------------------------
# Test time execution of xml2sql function
# -------------------------------------------------------------------
test_report.append("xml2sql")
emulate_execution(lambda: xml2sql(xml_filename="datasets.xml", sql_filename="database.sql"))()


# -------------------------------------------------------------------
# Test time execution of db2xml function
# -------------------------------------------------------------------
test_report.append("db2xml")
emulate_execution(lambda: db2xml(xml_filename="datasets.xml", db_filename="database.db"))()


# -------------------------------------------------------------------
# Save test report
# -------------------------------------------------------------------
with open(f".test_report{os.path.basename(__file__)}.txt", "w", encoding="utf-8") as f:
    f.write("\n".join(test_report))
