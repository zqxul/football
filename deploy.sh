
echo "=========== start deploy ==========="

echo "=========== login ==========="
sshpass -p w123456w ssh -t -t root@118.24.99.216 > /dev/null 2>&1 << eeooff
echo "=========== login success ==========="

echo "===========stop football-1.0.jar==========="
cd /usr
./stop.sh
echo "===========football-1.0.jar stoped==========="

echo "===========remove football-1.0.jar==========="
rm -rf football-1.0.jar
echo "===========football-1.0.jar removed==========="

echo "===========upload football-1.0.jar==========="
sshpass -p w123456w scp ./target/football-1.0.jar root@118.24.99.216:/usr/
echo "===========upload football-1.0.jar success==========="

echo "===========start football-1.0.jar==========="
./start.sh
echo "===========football-1.0.jar started==========="
exit
eeooff
echo done!