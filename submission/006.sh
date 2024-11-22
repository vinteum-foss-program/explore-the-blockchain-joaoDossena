# Which tx in block 257,343 spends the coinbase output of block 256,128?


txId=$(bitcoin-cli getblockhash 256128 | xargs bitcoin-cli getblock | jq -r '.tx | .[0]')
# bitcoin-cli getrawtransaction $txId  | xargs bitcoin-cli decoderawtransaction| jq 

txs=$(bitcoin-cli getblockhash 257343 | xargs bitcoin-cli getblock | jq -r '.tx | .[]')
# echo $txs
for tx in $txs; do 
    inputTxId=$(bitcoin-cli getrawtransaction $tx | xargs bitcoin-cli decoderawtransaction | jq '.vin | .[] | .txid')
    # echo $inputTxId
    if [[ $(echo "${inputTxId[@]}" | grep -Fw "$txId") ]]; then
        echo $tx
        break
    fi
done
