#!/usr/bin/env bash
SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)
CLI_INSTALL_BIN="${SCRIPT_DIR}/AWSCLIV2.pkg"
WHERE_XML_FILE_TEMPLATE="${SCRIPT_DIR}/where.xml.template"
WHERE_XML_FILE="${SCRIPT_DIR}/where.xml"

CLI_INSTALL_PATH=$(cd $(dirname "${BASH_SOURCE[0]}")/../../cli && pwd)


curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o ${CLI_INSTALL_BIN}
# Using parameter expansion https://www.gnu.org/savannah-checkouts/gnu/bash/manual/bash.html#Shell-Parameter-Expansion
# cf. https://stackoverflow.com/a/27788661/21052
cat ${WHERE_XML_FILE_TEMPLATE} | sed -e "s/CLI_INSTALL_PATH/${CLI_INSTALL_PATH//\//\\/}/" > ${WHERE_XML_FILE}
installer -pkg ${CLI_INSTALL_BIN} -target CurrentUserHomeDirectory -applyChoiceChangesXML ${WHERE_XML_FILE}


echo -e "AWS cli is installed:${CLI_INSTALL_PATH}"
export PATH=${CLI_INSTALL_PATH}/aws-cli:${PATH}
