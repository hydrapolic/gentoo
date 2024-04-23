# Copyright 2019-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="Wazuh program user"
ACCT_USER_ID=999
ACCT_USER_HOME=/var/ossec
ACCT_USER_HOME_PERMS=0750
ACCT_USER_GROUPS=( wazuh )
acct-user_add_deps
