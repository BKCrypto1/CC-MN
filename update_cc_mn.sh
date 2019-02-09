# This script will update your existing CampusCoin (CC) Masternode.

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

echo "Stopping CampusCoin MN Service"
systemctl stop CampusCoin.service
cd /usr/local/bin/
echo "Fetching latest CC linux zip..."
wget -c https://github.com/campuscoindev/CC/releases/download/3.0.2/cc_linux.zip
echo "Removing old CC files..."
sudo rm ccd cc-cli cc-tx
echo "Unzipping latest zip..."
sudo unzip cc_linux.zip
sudo rm cc-qt
sudo rm -R ~/.cc/backups/
sudo rm -R ~/.cc/blocks/
sudo rm -R ~/.cc/chainstate/
sudo rm -R ~/.cc/database/
sudo rm ~/.cc/budget.dat ~/.cc/db.log ~/.cc/debug.log ~/.cc/fee_estimates.dat ~/.cc/mncache.dat ~/.cc/mnpayments.dat ~/.cc/peers.dat
sudo rm cc_linux.zip
systemctl start CampusCoin.service
echo "CC Masternode Updated."
echo "------------------------------------------------------------------"
echo "Use ${GREEN}campuscoin-cli masternode status${NC} to check masternode status."
echo "Use ${GREEN}campuscoin-cli getblockcount${NC} to view current block count."
echo "------------------------------------------------------------------"