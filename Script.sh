# متغير يحدد مسار ملف السكربت لو وضعت داخل مجلد يحدد مسار ملف السكربت كامل
BASEDIR=$(dirname "$0")
# متغير لتحديد مسار المجلد
IPAIN="$BASEDIR"

# متغير لتحيد مجلد البرنامج بعد الانتهاء
Create_Folder="out"

# تحديد مسار المجلد
cd $IPAIN

#انشاأ مجلد جديد
mkdir $Create_Folder
#echo $IPAIN/Payload/$APPLICATION

# دوال لطباعة المدخلات
echo "  آكتب اسم البرنامج بالانجليزي واضغط انتر "
read -p " Type in an English name and press Enter : " appName
echo "آكتب اسم البرنامج بالانجليزي واضغط انتر "
read -p " Type in an English name and press Enter : " nameEn
echo "آكتب اسم البرنامج بالعربي واضغط انتر "
read -p " Type in an Arabic name and press Enter : " nameAr
echo "آكتب بندل للبرنامج واضغط انتر"
read -p " Type in an Arabic name and press Enter : " Bundle


cd $IPAIN


# شرط تحقق اذا في المدخلات قيمة يتم واذا فارغ لن يتم باقي الاكواد
if [ "$appName" == "" ]; then
echo  " 🤨 لم تكتب شيء "
echo  " الرجاء اكتب اسم للبرنامج في الانجليزي"

exit
fi

if [ "$appName" == "" ]; then
echo  " 🤨 لم تكتب شيء "
echo  " الرجاء اكتب اسم للبرنامج"
exit
fi

if [ "$nameEn" == "" ]; then
echo  " 🤨 لم تكتب شيء "
echo  " الرجاء اكتب اسم للبرنامج في الانجليزي"
exit
fi


if [ "$nameAr" == "" ]; then
echo  " 🤨 لم تكتب شيء "
echo  " الرجاء اكتب اسم للبرنامج في العربي"
exit
fi

if [ "$Bundle" == "" ]; then
echo  " 🤨 لم تكتب شيء "
echo  " الرجاء اكتب البندل"
exit
fi

# حذف مجلد البرامج لاجل يتم انشائه من جديد
rm -r Payload
# فك الضغط عن البرنامج
unzip *.ipa
rm -r __MACOSX

# متغير مسار ملف بلست اللغة
EnString="en.lproj/InfoPlist.strings"
ArString="ar.lproj/InfoPlist.strings"
# متغير لمسار ملف الانفو بلست
infoplist="info.plist"

EnPlist="en.lproj/InfoPlist.plist"
ArPlist="ar.lproj/InfoPlist.plist"



APPLICATION=$(ls "$IPAIN/Payload/")

# تغير اسم البرنامج داخل مجلد اللغات
/usr/libexec/PlistBuddy -c "Set :CFBundleDisplayName $nameEn" $IPAIN/Payload/$APPLICATION/$EnString
/usr/libexec/PlistBuddy -c "Set :CFBundleDisplayName $nameAr" $IPAIN/Payload/$APPLICATION/$ArString

# تغير اسم البرنامج داخل ملف الانفو بلست
/usr/libexec/PlistBuddy -c "Set :CFBundleDisplayName $nameEn" $IPAIN/Payload/$APPLICATION/$infoplist
/usr/libexec/PlistBuddy -c "Set :CFBundleName $nameEn" $IPAIN/Payload/$APPLICATION/$infoplist

# تغير بندل البرنامج داخل ملف الانفو بلست
/usr/libexec/PlistBuddy -c "Set :CFBundleIdentifier $Bundle"  $IPAIN/Payload/$APPLICATION/$infoplist
##FacebookDisplayName

# ضغط مجلد البرنامج
zip -r Payload.zip Payload

mv Payload.zip $appName.ipa
mv $appName.ipa $Create_Folder

rm -r Payload

echo " "
echo " "
echo " "
echo " تم الإنتهاء "
echo " برمجة نواف منصور "



