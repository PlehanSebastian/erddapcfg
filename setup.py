from setuptools import setup

setup(
    name="erddapcfg",
    version="0.0.0",
    description="Python program to work with ERDDAP configurations.",
    author="Sebastian Plehan",
    author_email="plehan.sebastian@gmail.com",
    packages=[
        "erddapcfg",
    ],
    entry_points={
        "console_scripts": ["erddapcfg=erddapcfg.cli:cli_entry_point"],
    },
    install_requires=[
        "pandas",
        "jinja2",
    ],
)
