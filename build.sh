echo "Init build...";

echo " 1/6 ==> Removing old builds folders";
rm -R build;
rm -R adrian;

echo " 2/6 ==> Generate files";
./create_repository.py --datadir=build https://github.com/adrianfg92/kodi.backups ./repository;

echo " 3/6 ==> Create \"adrian\" folder";
mkdir adrian;

echo " 4/6 ==> Copy all zip files";
cp -r build/**/*.zip adrian;

echo " 5/6 ==> Creating index.html";

zips=`ls adrian`
echo '<!DOCTYPE html>' > adrian/index.html;
for name_zip in $zips
do
  echo "<a href=\"$name_zip\">$name_zip</a>" >> adrian/index.html;
done

echo " 6/6 ==> Commit and push";
git add .;
git commit -am "Update";
git push;
