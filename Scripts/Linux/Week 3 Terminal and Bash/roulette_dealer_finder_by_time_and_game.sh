grep -i "$2" $1_Dealer_schedule > Find_Dealer 
if [[ $3 == 'BlackJack' ]]; then
  awk -F" " '{print $1,$2,$3,$4}' Find_Dealer;
elif [[ $3 == 'Roulette' ]]; then
  awk -F" " '{print $1,$2,$5,$6}' Find_Dealer;
elif [[ $3 == 'Texas Hold EM' ]]; then
  awk -F" " '{print $1,$2,$7,$8}' Find_Dealer;
else 
  echo 'That is not a valid Casino game.';
fi
