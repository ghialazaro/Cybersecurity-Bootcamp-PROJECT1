$ cat roulette_dealer_finder_by_time.sh
#!/bin/bash
grep -i "$2" $1_Dealer_schedule | awk -F" " '{print $1,$2,$5,$6}'
