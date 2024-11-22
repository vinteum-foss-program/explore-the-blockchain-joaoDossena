# How many new outputs were created by block 123,456?
txs=$(bitcoin-cli getblockhash 123456 | xargs bitcoin-cli getblock | jq '.tx | .[]')
# echo "Transactions:\n$txs"
n_outputs=0
for i in $txs
do
i=$(echo $i | tr -d '"')
tmp=$(bitcoin-cli getrawtransaction $i | xargs bitcoin-cli decoderawtransaction | jq '.vout | length')
# echo "For transaction $i: $tmp outputs"
n_outputs=$(($n_outputs+$tmp))
done
echo $n_outputs