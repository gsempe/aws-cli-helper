#!/usr/bin/env bash

function usage
{
    echo "usage: $0 -t 123456 --token 123456 | -d 129600 --duration 129600 | -h"
    echo ""
    echo "Examples:"
    echo "- shortest duration:"
    echo "  $0 -t 123456 -d 900"
}

token=
duration=

while [ "$1" != "" ]; do
	case $1 in
		-t | --token )		shift
					token=$1
					;;
		-d | --duration )	shift
					duration=$1
					;;
		-h | --help )          	usage
					exit
					;;
		* )                    	usage
					exit 1
	esac
	shift
done

if [ "$token" == "" ]; then
	usage
	exit 1
fi

if [ "$duration" == "" ]; then
	duration=900
fi

ARN_IAM_MFA=arn:aws:iam::XXXXXXXXXXXX:mfa/Guillaume

res = $(aws sts get-session-token --serial-number ${ARN_IAM_MFA} --token-code ${token}  --duration-seconds ${duration})
