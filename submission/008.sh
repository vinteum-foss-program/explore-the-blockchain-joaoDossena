# Which public key signed input 0 in this tx:
#   `e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163`

rawScript=$(bitcoin-cli getrawtransaction "e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163" | xargs bitcoin-cli decoderawtransaction | jq -r '.vin | .[] | .txinwitness | .[2]')
bitcoin-cli decodescript $rawScript | jq -r '.asm' | awk -F ' ' '{print $2}'
# echo ${words[1]}
