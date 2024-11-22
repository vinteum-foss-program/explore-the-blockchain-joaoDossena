# Only one single output remains unspent from block 123,321. What address was it sent to?


txs=$(bitcoin-cli getblockhash 123321 | xargs bitcoin-cli getblock | jq -r '.tx | .[]')
for tx in $txs; do
    vout=$(bitcoin-cli getrawtransaction $tx | xargs bitcoin-cli decoderawtransaction | jq -r '.vout | length')
    addr=$(bitcoin-cli getrawtransaction $tx | xargs bitcoin-cli decoderawtransaction | jq -r '.vout | .[] | .scriptPubKey | .address')

    # echo "Txid: $tx | Vout: $vout Addr: $addr"
    for i in $(seq 0 $vout); do
        res=$(bitcoin-cli gettxout $tx $i)
        if [[ -n $res ]]; then
            echo $res | jq -r '.scriptPubKey | .address'
            break
        fi
    done
done