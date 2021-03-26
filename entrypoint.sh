#!/bin/bash

if grep -q 'super secret unguessable key' /kavita/appsettings.json
then
	export TOKEN_KEY="$(pwgen -s 16 1)"
	sed -i "s/super secret unguessable key/${TOKEN_KEY}/g" /kavita/appsettings.json
fi

./Kavita
