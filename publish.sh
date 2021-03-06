#!/bin/sh

VERSION=$(cat version.txt)

echo "Clear previous builds..." && \
rm -rf env/ && rm -rf build/ && \
rm -rf dist/ && rm -rf walkman.egg-info/ && \

echo "Create a new brand virtual env..." && \
python -m venv env && \

echo "Activating virtual env..." && \
source env/bin/activate && \

echo "Installing requirements..." && \
pip install -r requirements-dev.txt && \

echo "Auditing code..." && \
flake8 && \

echo "Generating dist package..." && \
python setup.py sdist bdist_wheel && \

echo "Uploading version $VERSION..." && \
twine upload dist/* && \

echo "Creating tag..." && \
git tag $VERSION && \
git push origin $VERSION && \

echo "Done!"