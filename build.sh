echo "Init build...";

echo " 1/6 ==> Removing old builds folders";
rm -R repo;

echo " 2/6 ==> Generate files";
./create_repository.py --datadir=build https://github.com/adrianfg92/kodi.backups ./repository;

echo " 3/6 ==> Create \"repo\" folder";
mkdir repo;

echo " 4/6 ==> Copy all zip files";
cp -r build/**/*.zip repo;
rm -R build;

echo " 5/6 ==> Creating index.html";

zips=`ls repo`
echo '<!DOCTYPE html>' > repo/index.html;
for name_zip in $zips
do
  echo "<a href=\"$name_zip\">$name_zip</a>" >> repo/index.html;
done

echo " 6/6 ==> Commit and push";
git add .;
git commit -am "Update";
git push;
