# This script will update your existing CampusCoin (CC) Masternode.

CONFIGFOLDER='/root/.cc'
COIN_SNAPSHOT='https://www.dropbox.com/s/j0d2bril4ehbwzc/cc_snapshot.zip'

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${RED}Stopping CampusCoin MN Service${NC}"
systemctl stop CampusCoin.service
cd /usr/local/bin/

echo -e "${GREEN}Fetching latest CC linux zip...${NC}"
wget -c https://github.com/campuscoindev/CC/releases/download/3.0.2/cc_linux.zip

echo -e "${GREEN}Removing old CC files...${NC}"
sudo rm ccd cc-cli cc-tx

echo -e "${GREEN}Unzipping latest zip...${NC}"
sudo unzip cc_linux.zip
sudo rm cc-qt
sudo rm -R ~/.cc/backups/
sudo rm -R ~/.cc/blocks/
sudo rm -R ~/.cc/chainstate/
sudo rm -R ~/.cc/database/
sudo rm ~/.cc/budget.dat ~/.cc/db.log ~/.cc/debug.log ~/.cc/fee_estimates.dat ~/.cc/mncache.dat ~/.cc/mnpayments.dat ~/.cc/peers.dat
sudo rm cc_linux.zip

echo -e "${GREEN}Fetching CC Snapshot...${NC}"
TMP_FOLDER=$(mktemp -d)
  cd $TMP_FOLDER
  wget --progress=bar:force $COIN_SNAPSHOT 2>&1
  unzip cc_snapshot.zip -d $CONFIGFOLDER/
  cd -
  rm -rf $TMP_FOLDER >/dev/null 2>&1

echo -e "${GREEN}Starting CC Service..."
systemctl start CampusCoin.service

echo -e "${GREEN}CC Masternode Updated.${NC}"
echo -e "------------------------------------------------------------------"
echo -e "${RED}Useful Commands:${NC}"
echo -e "Use ${RED}cc-cli masternode status${NC} to check masternode status."
echo -e "Use ${RED}cc-cli getblockcount${NC} to view current block count."
echo -e "Use ${RED}cc-cli getinfo${NC} to view coin info."