#!/bin/bash

cd "/"

# Rename libraries
sudo mv "/Applications/Imaris 7.6.0.app/Contents/Frameworks/QtCore.framework/Versions/4/QtCore" \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/QtCore.framework/Versions/4/QtCore48"
sudo mv "/Applications/Imaris 7.6.0.app/Contents/Frameworks/QtDeclarative.framework/Versions/4/QtDeclarative" \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/QtDeclarative.framework/Versions/4/QtDeclarative48"
sudo mv "/Applications/Imaris 7.6.0.app/Contents/Frameworks/QtGui.framework/Versions/4/QtGui" \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/QtGui.framework/Versions/4/QtGui48"
sudo mv "/Applications/Imaris 7.6.0.app/Contents/Frameworks/QtNetwork.framework/Versions/4/QtNetwork" \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/QtNetwork.framework/Versions/4/QtNetwork48"
sudo mv "/Applications/Imaris 7.6.0.app/Contents/Frameworks/QtOpenGL.framework/Versions/4/QtOpenGL" \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/QtOpenGL.framework/Versions/4/QtOpenGL48"
sudo mv "/Applications/Imaris 7.6.0.app/Contents/Frameworks/QtScript.framework/Versions/4/QtScript" \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/QtScript.framework/Versions/4/QtScript48"
sudo mv "/Applications/Imaris 7.6.0.app/Contents/Frameworks/QtSql.framework/Versions/4/QtSql" \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/QtSql.framework/Versions/4/QtSql48"
sudo mv "/Applications/Imaris 7.6.0.app/Contents/Frameworks/QtSvg.framework/Versions/4/QtSvg" \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/QtSvg.framework/Versions/4/QtSvg48"
sudo mv "/Applications/Imaris 7.6.0.app/Contents/Frameworks/QtXml.framework/Versions/4/QtXml" \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/QtXml.framework/Versions/4/QtXml48"
sudo mv "/Applications/Imaris 7.6.0.app/Contents/Frameworks/QtXmlPatterns.framework/Versions/4/QtXmlPatterns" \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/QtXmlPatterns.framework/Versions/4/QtXmlPatterns48"

# Change ID
sudo install_name_tool -id @loader_path/QtCore.framework/Versions/4/QtCore48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/QtCore.framework/Versions/4/QtCore48"	
sudo install_name_tool -id @loader_path/QtDeclarative.framework/Versions/4/QtDeclarative48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/QtDeclarative.framework/Versions/4/QtDeclarative48"
sudo install_name_tool -id @loader_path/QtGui.framework/Versions/4/QtGui48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/QtGui.framework/Versions/4/QtGui48"
sudo install_name_tool -id @loader_path/QtNetwork.framework/Versions/4/QtNetwork48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/QtNetwork.framework/Versions/4/QtNetwork48"
sudo install_name_tool -id @loader_path/QtOpenGL.framework/Versions/4/QtOpenGL48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/QtOpenGL.framework/Versions/4/QtOpenGL48"
sudo install_name_tool -id @loader_path/QtScript.framework/Versions/4/QtScript48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/QtScript.framework/Versions/4/QtScript48"
sudo install_name_tool -id @loader_path/QtSql.framework/Versions/4/QtSql48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/QtSql.framework/Versions/4/QtSql48"
sudo install_name_tool -id @loader_path/QtSvg.framework/Versions/4/QtSvg48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/QtSvg.framework/Versions/4/QtSvg48"
sudo install_name_tool -id @loader_path/QtXml.framework/Versions/4/QtXml48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/QtXml.framework/Versions/4/QtXml48"
sudo install_name_tool -id @loader_path/QtXmlPatterns.framework/Versions/4/QtXmlPatterns48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/QtXmlPatterns.framework/Versions/4/QtXmlPatterns48"

# Change the references of the Qt frameworks with each other
sudo install_name_tool -change \
	@loader_path/../../../QtCore.framework/Versions/4/QtCore \
	@loader_path/../../../QtCore.framework/Versions/4/QtCore48 \
	"/Applications/Imaris 7.6.0.app/Contents/MacOS/../Frameworks/QtGui.framework/Versions/4/QtGui48"
sudo install_name_tool -change \
	@loader_path/../../../QtCore.framework/Versions/4/QtCore \
	@loader_path/../../../QtCore.framework/Versions/4/QtCore48 \
	"/Applications/Imaris 7.6.0.app/Contents/MacOS/../Frameworks/QtNetwork.framework/Versions/4/QtNetwork48"
sudo install_name_tool -change \
	@loader_path/../../../QtGui.framework/Versions/4/QtGui \
	@loader_path/../../../QtGui.framework/Versions/4/QtGui48 \
	"/Applications/Imaris 7.6.0.app/Contents/MacOS/../Frameworks/QtOpenGL.framework/Versions/4/QtOpenGL48"
sudo install_name_tool -change \
	@loader_path/../../../QtCore.framework/Versions/4/QtCore \
	@loader_path/../../../QtCore.framework/Versions/4/QtCore48 \
	"/Applications/Imaris 7.6.0.app/Contents/MacOS/../Frameworks/QtOpenGL.framework/Versions/4/QtOpenGL48"
sudo install_name_tool -change \
	@loader_path/../../../QtCore.framework/Versions/4/QtCore \
	@loader_path/../../../QtCore.framework/Versions/4/QtCore48 \
	"/Applications/Imaris 7.6.0.app/Contents/MacOS/../Frameworks/QtXML.framework/Versions/4/QtXML48"
sudo install_name_tool -change \
	@loader_path/../../../QtCore.framework/Versions/4/QtCore \
	@loader_path/../../../QtCore.framework/Versions/4/QtCore48 \
	"/Applications/Imaris 7.6.0.app/Contents/MacOS/../Frameworks/QtSql.framework/Versions/4/QtSql48"

# Change the references of other libs
sudo install_name_tool -change @loader_path/QtCore.framework/Versions/4/QtCore \
	@loader_path/QtCore.framework/Versions/4/QtCore48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libCg.2.1.dylib"
sudo install_name_tool -change @loader_path/QtCore.framework/Versions/4/QtCore \
	@loader_path/QtCore.framework/Versions/4/QtCore48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libCoin.60.dylib"
sudo install_name_tool -change @loader_path/QtCore.framework/Versions/4/QtCore \
	@loader_path/QtCore.framework/Versions/4/QtCore48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libIce.34.dylib"
sudo install_name_tool -change @loader_path/QtCore.framework/Versions/4/QtCore \
	@loader_path/QtCore.framework/Versions/4/QtCore48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libSBReadFile.dylib"
sudo install_name_tool -change @loader_path/QtCore.framework/Versions/4/QtCore \
	@loader_path/QtCore.framework/Versions/4/QtCore48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libSoQt.20.dylib"
sudo install_name_tool -change @loader_path/QtCore.framework/Versions/4/QtCore \
	@loader_path/QtCore.framework/Versions/4/QtCore48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libavcodec.dylib"
sudo install_name_tool -change @loader_path/QtCore.framework/Versions/4/QtCore \
	@loader_path/QtCore.framework/Versions/4/QtCore48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libavformat.dylib"
sudo install_name_tool -change @loader_path/QtCore.framework/Versions/4/QtCore \
	@loader_path/QtCore.framework/Versions/4/QtCore48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libavutil.dylib"
sudo install_name_tool -change @loader_path/QtCore.framework/Versions/4/QtCore \
	@loader_path/QtCore.framework/Versions/4/QtCore48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpBatchIcePlugin.7.6.dylib"
sudo install_name_tool -change @loader_path/QtCore.framework/Versions/4/QtCore \
	@loader_path/QtCore.framework/Versions/4/QtCore48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpImarisBatchAgent.7.6.dylib"
sudo install_name_tool -change @loader_path/QtCore.framework/Versions/4/QtCore \
	@loader_path/QtCore.framework/Versions/4/QtCore48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpImarisGraphics.7.5.dylib"
sudo install_name_tool -change @loader_path/QtCore.framework/Versions/4/QtCore \
	@loader_path/QtCore.framework/Versions/4/QtCore48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpImarisStorage.7.5.dylib"
sudo install_name_tool -change @loader_path/QtCore.framework/Versions/4/QtCore \
	@loader_path/QtCore.framework/Versions/4/QtCore48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpcore.7.6.dylib"
sudo install_name_tool -change @loader_path/QtCore.framework/Versions/4/QtCore \
	@loader_path/QtCore.framework/Versions/4/QtCore48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpexception.7.6.dylib"
sudo install_name_tool -change @loader_path/QtCore.framework/Versions/4/QtCore \
	@loader_path/QtCore.framework/Versions/4/QtCore48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpfileio.7.6.dylib"
sudo install_name_tool -change @loader_path/QtCore.framework/Versions/4/QtCore \
	@loader_path/QtCore.framework/Versions/4/QtCore48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libexpat.1.dylib"
sudo install_name_tool -change @loader_path/QtCore.framework/Versions/4/QtCore \
	@loader_path/QtCore.framework/Versions/4/QtCore48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libfreeimage-3.15.0.dylib"
sudo install_name_tool -change @loader_path/QtCore.framework/Versions/4/QtCore \
	@loader_path/QtCore.framework/Versions/4/QtCore48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libhdf5.7.dylib"
sudo install_name_tool -change @loader_path/QtCore.framework/Versions/4/QtCore \
	@loader_path/QtCore.framework/Versions/4/QtCore48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libswscale.dylib"
###
sudo install_name_tool -change @loader_path/QtDeclarative.framework/Versions/4/QtDeclarative \
	@loader_path/QtDeclarative.framework/Versions/4/QtDeclarative48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libCg.2.1.dylib"
sudo install_name_tool -change @loader_path/QtDeclarative.framework/Versions/4/QtDeclarative \
	@loader_path/QtDeclarative.framework/Versions/4/QtDeclarative48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libCoin.60.dylib"
sudo install_name_tool -change @loader_path/QtDeclarative.framework/Versions/4/QtDeclarative \
	@loader_path/QtDeclarative.framework/Versions/4/QtDeclarative48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libIce.34.dylib"
sudo install_name_tool -change @loader_path/QtDeclarative.framework/Versions/4/QtDeclarative \
	@loader_path/QtDeclarative.framework/Versions/4/QtDeclarative48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libSBReadFile.dylib"
sudo install_name_tool -change @loader_path/QtDeclarative.framework/Versions/4/QtDeclarative \
	@loader_path/QtDeclarative.framework/Versions/4/QtDeclarative48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libSoQt.20.dylib"
sudo install_name_tool -change @loader_path/QtDeclarative.framework/Versions/4/QtDeclarative \
	@loader_path/QtDeclarative.framework/Versions/4/QtDeclarative48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libavcodec.dylib"
sudo install_name_tool -change @loader_path/QtDeclarative.framework/Versions/4/QtDeclarative \
	@loader_path/QtDeclarative.framework/Versions/4/QtDeclarative48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libavformat.dylib"
sudo install_name_tool -change @loader_path/QtDeclarative.framework/Versions/4/QtDeclarative \
	@loader_path/QtDeclarative.framework/Versions/4/QtDeclarative48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libavutil.dylib"
sudo install_name_tool -change @loader_path/QtDeclarative.framework/Versions/4/QtDeclarative \
	@loader_path/QtDeclarative.framework/Versions/4/QtDeclarative48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpBatchIcePlugin.7.6.dylib"
sudo install_name_tool -change @loader_path/QtDeclarative.framework/Versions/4/QtDeclarative \
	@loader_path/QtDeclarative.framework/Versions/4/QtDeclarative48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpImarisBatchAgent.7.6.dylib"
sudo install_name_tool -change @loader_path/QtDeclarative.framework/Versions/4/QtDeclarative \
	@loader_path/QtDeclarative.framework/Versions/4/QtDeclarative48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpImarisGraphics.7.5.dylib"
sudo install_name_tool -change @loader_path/QtDeclarative.framework/Versions/4/QtDeclarative \
	@loader_path/QtDeclarative.framework/Versions/4/QtDeclarative48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpImarisStorage.7.5.dylib"
sudo install_name_tool -change @loader_path/QtDeclarative.framework/Versions/4/QtDeclarative \
	@loader_path/QtDeclarative.framework/Versions/4/QtDeclarative48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpcore.7.6.dylib"
sudo install_name_tool -change @loader_path/QtDeclarative.framework/Versions/4/QtDeclarative \
	@loader_path/QtDeclarative.framework/Versions/4/QtDeclarative48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpexception.7.6.dylib"
sudo install_name_tool -change @loader_path/QtDeclarative.framework/Versions/4/QtDeclarative \
	@loader_path/QtDeclarative.framework/Versions/4/QtDeclarative48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpfileio.7.6.dylib"
sudo install_name_tool -change @loader_path/QtDeclarative.framework/Versions/4/QtDeclarative \
	@loader_path/QtDeclarative.framework/Versions/4/QtDeclarative48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libexpat.1.dylib"
sudo install_name_tool -change @loader_path/QtDeclarative.framework/Versions/4/QtDeclarative \
	@loader_path/QtDeclarative.framework/Versions/4/QtDeclarative48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libfreeimage-3.15.0.dylib"
sudo install_name_tool -change @loader_path/QtDeclarative.framework/Versions/4/QtDeclarative \
	@loader_path/QtDeclarative.framework/Versions/4/QtDeclarative48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libhdf5.7.dylib"
sudo install_name_tool -change @loader_path/QtDeclarative.framework/Versions/4/QtDeclarative \
	@loader_path/QtDeclarative.framework/Versions/4/QtDeclarative48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libswscale.dylib"
###
sudo install_name_tool -change @loader_path/QtGui.framework/Versions/4/QtGui \
	@loader_path/QtGui.framework/Versions/4/QtGui48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libCg.2.1.dylib"
sudo install_name_tool -change @loader_path/QtGui.framework/Versions/4/QtGui \
	@loader_path/QtGui.framework/Versions/4/QtGui48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libCoin.60.dylib"
sudo install_name_tool -change @loader_path/QtGui.framework/Versions/4/QtGui \
	@loader_path/QtGui.framework/Versions/4/QtGui48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libIce.34.dylib"
sudo install_name_tool -change @loader_path/QtGui.framework/Versions/4/QtGui \
	@loader_path/QtGui.framework/Versions/4/QtGui48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libSBReadFile.dylib"
sudo install_name_tool -change @loader_path/QtGui.framework/Versions/4/QtGui \
	@loader_path/QtGui.framework/Versions/4/QtGui48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libSoQt.20.dylib"
sudo install_name_tool -change @loader_path/QtGui.framework/Versions/4/QtGui \
	@loader_path/QtGui.framework/Versions/4/QtGui48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libavcodec.dylib"
sudo install_name_tool -change @loader_path/QtGui.framework/Versions/4/QtGui \
	@loader_path/QtGui.framework/Versions/4/QtGui48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libavformat.dylib"
sudo install_name_tool -change @loader_path/QtGui.framework/Versions/4/QtGui \
	@loader_path/QtGui.framework/Versions/4/QtGui48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libavutil.dylib"
sudo install_name_tool -change @loader_path/QtGui.framework/Versions/4/QtGui \
	@loader_path/QtGui.framework/Versions/4/QtGui48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpBatchIcePlugin.7.6.dylib"
sudo install_name_tool -change @loader_path/QtGui.framework/Versions/4/QtGui \
	@loader_path/QtGui.framework/Versions/4/QtGui48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpImarisBatchAgent.7.6.dylib"
sudo install_name_tool -change @loader_path/QtGui.framework/Versions/4/QtGui \
	@loader_path/QtGui.framework/Versions/4/QtGui48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpImarisGraphics.7.5.dylib"
sudo install_name_tool -change @loader_path/QtGui.framework/Versions/4/QtGui \
	@loader_path/QtGui.framework/Versions/4/QtGui48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpImarisStorage.7.5.dylib"
sudo install_name_tool -change @loader_path/QtGui.framework/Versions/4/QtGui \
	@loader_path/QtGui.framework/Versions/4/QtGui48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpcore.7.6.dylib"
sudo install_name_tool -change @loader_path/QtGui.framework/Versions/4/QtGui \
	@loader_path/QtGui.framework/Versions/4/QtGui48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpexception.7.6.dylib"
sudo install_name_tool -change @loader_path/QtGui.framework/Versions/4/QtGui \
	@loader_path/QtGui.framework/Versions/4/QtGui48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpfileio.7.6.dylib"
sudo install_name_tool -change @loader_path/QtGui.framework/Versions/4/QtGui \
	@loader_path/QtGui.framework/Versions/4/QtGui48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libexpat.1.dylib"
sudo install_name_tool -change @loader_path/QtGui.framework/Versions/4/QtGui \
	@loader_path/QtGui.framework/Versions/4/QtGui48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libfreeimage-3.15.0.dylib"
sudo install_name_tool -change @loader_path/QtGui.framework/Versions/4/QtGui \
	@loader_path/QtGui.framework/Versions/4/QtGui48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libhdf5.7.dylib"
sudo install_name_tool -change @loader_path/QtGui.framework/Versions/4/QtGui \
	@loader_path/QtGui.framework/Versions/4/QtGui48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libswscale.dylib"
###
sudo install_name_tool -change @loader_path/QtNetwork.framework/Versions/4/QtNetwork \
	@loader_path/QtNetwork.framework/Versions/4/QtNetwork48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libCg.2.1.dylib"
sudo install_name_tool -change @loader_path/QtNetwork.framework/Versions/4/QtNetwork \
	@loader_path/QtNetwork.framework/Versions/4/QtNetwork48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libCoin.60.dylib"
sudo install_name_tool -change @loader_path/QtNetwork.framework/Versions/4/QtNetwork \
	@loader_path/QtNetwork.framework/Versions/4/QtNetwork48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libIce.34.dylib"
sudo install_name_tool -change @loader_path/QtNetwork.framework/Versions/4/QtNetwork \
	@loader_path/QtNetwork.framework/Versions/4/QtNetwork48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libSBReadFile.dylib"
sudo install_name_tool -change @loader_path/QtNetwork.framework/Versions/4/QtNetwork \
	@loader_path/QtNetwork.framework/Versions/4/QtNetwork48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libSoQt.20.dylib"
sudo install_name_tool -change @loader_path/QtNetwork.framework/Versions/4/QtNetwork \
	@loader_path/QtNetwork.framework/Versions/4/QtNetwork48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libavcodec.dylib"
sudo install_name_tool -change @loader_path/QtNetwork.framework/Versions/4/QtNetwork \
	@loader_path/QtNetwork.framework/Versions/4/QtNetwork48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libavformat.dylib"
sudo install_name_tool -change @loader_path/QtNetwork.framework/Versions/4/QtNetwork \
	@loader_path/QtNetwork.framework/Versions/4/QtNetwork48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libavutil.dylib"
sudo install_name_tool -change @loader_path/QtNetwork.framework/Versions/4/QtNetwork \
	@loader_path/QtNetwork.framework/Versions/4/QtNetwork48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpBatchIcePlugin.7.6.dylib"
sudo install_name_tool -change @loader_path/QtNetwork.framework/Versions/4/QtNetwork \
	@loader_path/QtNetwork.framework/Versions/4/QtNetwork48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpImarisBatchAgent.7.6.dylib"
sudo install_name_tool -change @loader_path/QtNetwork.framework/Versions/4/QtNetwork \
	@loader_path/QtNetwork.framework/Versions/4/QtNetwork48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpImarisGraphics.7.5.dylib"
sudo install_name_tool -change @loader_path/QtNetwork.framework/Versions/4/QtNetwork \
	@loader_path/QtNetwork.framework/Versions/4/QtNetwork48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpImarisStorage.7.5.dylib"
sudo install_name_tool -change @loader_path/QtNetwork.framework/Versions/4/QtNetwork \
	@loader_path/QtNetwork.framework/Versions/4/QtNetwork48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpcore.7.6.dylib"
sudo install_name_tool -change @loader_path/QtNetwork.framework/Versions/4/QtNetwork \
	@loader_path/QtNetwork.framework/Versions/4/QtNetwork48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpexception.7.6.dylib"
sudo install_name_tool -change @loader_path/QtNetwork.framework/Versions/4/QtNetwork \
	@loader_path/QtNetwork.framework/Versions/4/QtNetwork48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpfileio.7.6.dylib"
sudo install_name_tool -change @loader_path/QtNetwork.framework/Versions/4/QtNetwork \
	@loader_path/QtNetwork.framework/Versions/4/QtNetwork48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libexpat.1.dylib"
sudo install_name_tool -change @loader_path/QtNetwork.framework/Versions/4/QtNetwork \
	@loader_path/QtNetwork.framework/Versions/4/QtNetwork48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libfreeimage-3.15.0.dylib"
sudo install_name_tool -change @loader_path/QtNetwork.framework/Versions/4/QtNetwork \
	@loader_path/QtNetwork.framework/Versions/4/QtNetwork48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libhdf5.7.dylib"
sudo install_name_tool -change @loader_path/QtNetwork.framework/Versions/4/QtNetwork \
	@loader_path/QtNetwork.framework/Versions/4/QtNetwork48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libswscale.dylib"
###
sudo install_name_tool -change @loader_path/QtOpenGL.framework/Versions/4/QtOpenGL \
	@loader_path/QtOpenGL.framework/Versions/4/QtOpenGL48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libCg.2.1.dylib"
sudo install_name_tool -change @loader_path/QtOpenGL.framework/Versions/4/QtOpenGL \
	@loader_path/QtOpenGL.framework/Versions/4/QtOpenGL48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libCoin.60.dylib"
sudo install_name_tool -change @loader_path/QtOpenGL.framework/Versions/4/QtOpenGL \
	@loader_path/QtOpenGL.framework/Versions/4/QtOpenGL48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libIce.34.dylib"
sudo install_name_tool -change @loader_path/QtOpenGL.framework/Versions/4/QtOpenGL \
	@loader_path/QtOpenGL.framework/Versions/4/QtOpenGL48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libSBReadFile.dylib"
sudo install_name_tool -change @loader_path/QtOpenGL.framework/Versions/4/QtOpenGL \
	@loader_path/QtOpenGL.framework/Versions/4/QtOpenGL48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libSoQt.20.dylib"
sudo install_name_tool -change @loader_path/QtOpenGL.framework/Versions/4/QtOpenGL \
	@loader_path/QtOpenGL.framework/Versions/4/QtOpenGL48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libavcodec.dylib"
sudo install_name_tool -change @loader_path/QtOpenGL.framework/Versions/4/QtOpenGL \
	@loader_path/QtOpenGL.framework/Versions/4/QtOpenGL48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libavformat.dylib"
sudo install_name_tool -change @loader_path/QtOpenGL.framework/Versions/4/QtOpenGL \
	@loader_path/QtOpenGL.framework/Versions/4/QtOpenGL48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libavutil.dylib"
sudo install_name_tool -change @loader_path/QtOpenGL.framework/Versions/4/QtOpenGL \
	@loader_path/QtOpenGL.framework/Versions/4/QtOpenGL48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpBatchIcePlugin.7.6.dylib"
sudo install_name_tool -change @loader_path/QtOpenGL.framework/Versions/4/QtOpenGL \
	@loader_path/QtOpenGL.framework/Versions/4/QtOpenGL48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpImarisBatchAgent.7.6.dylib"
sudo install_name_tool -change @loader_path/QtOpenGL.framework/Versions/4/QtOpenGL \
	@loader_path/QtOpenGL.framework/Versions/4/QtOpenGL48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpImarisGraphics.7.5.dylib"
sudo install_name_tool -change @loader_path/QtOpenGL.framework/Versions/4/QtOpenGL \
	@loader_path/QtOpenGL.framework/Versions/4/QtOpenGL48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpImarisStorage.7.5.dylib"
sudo install_name_tool -change @loader_path/QtOpenGL.framework/Versions/4/QtOpenGL \
	@loader_path/QtOpenGL.framework/Versions/4/QtOpenGL48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpcore.7.6.dylib"
sudo install_name_tool -change @loader_path/QtOpenGL.framework/Versions/4/QtOpenGL \
	@loader_path/QtOpenGL.framework/Versions/4/QtOpenGL48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpexception.7.6.dylib"
sudo install_name_tool -change @loader_path/QtOpenGL.framework/Versions/4/QtOpenGL \
	@loader_path/QtOpenGL.framework/Versions/4/QtOpenGL48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpfileio.7.6.dylib"
sudo install_name_tool -change @loader_path/QtOpenGL.framework/Versions/4/QtOpenGL \
	@loader_path/QtOpenGL.framework/Versions/4/QtOpenGL48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libexpat.1.dylib"
sudo install_name_tool -change @loader_path/QtOpenGL.framework/Versions/4/QtOpenGL \
	@loader_path/QtOpenGL.framework/Versions/4/QtOpenGL48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libfreeimage-3.15.0.dylib"
sudo install_name_tool -change @loader_path/QtOpenGL.framework/Versions/4/QtOpenGL \
	@loader_path/QtOpenGL.framework/Versions/4/QtOpenGL48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libhdf5.7.dylib"
sudo install_name_tool -change @loader_path/QtOpenGL.framework/Versions/4/QtOpenGL \
	@loader_path/QtOpenGL.framework/Versions/4/QtOpenGL48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libswscale.dylib"
###
sudo install_name_tool -change @loader_path/QtScript.framework/Versions/4/QtScript \
	@loader_path/QtScript.framework/Versions/4/QtScript48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libCg.2.1.dylib"
sudo install_name_tool -change @loader_path/QtScript.framework/Versions/4/QtScript \
	@loader_path/QtScript.framework/Versions/4/QtScript48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libCoin.60.dylib"
sudo install_name_tool -change @loader_path/QtScript.framework/Versions/4/QtScript \
	@loader_path/QtScript.framework/Versions/4/QtScript48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libIce.34.dylib"
sudo install_name_tool -change @loader_path/QtScript.framework/Versions/4/QtScript \
	@loader_path/QtScript.framework/Versions/4/QtScript48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libSBReadFile.dylib"
sudo install_name_tool -change @loader_path/QtScript.framework/Versions/4/QtScript \
	@loader_path/QtScript.framework/Versions/4/QtScript48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libSoQt.20.dylib"
sudo install_name_tool -change @loader_path/QtScript.framework/Versions/4/QtScript \
	@loader_path/QtScript.framework/Versions/4/QtScript48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libavcodec.dylib"
sudo install_name_tool -change @loader_path/QtScript.framework/Versions/4/QtScript \
	@loader_path/QtScript.framework/Versions/4/QtScript48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libavformat.dylib"
sudo install_name_tool -change @loader_path/QtScript.framework/Versions/4/QtScript \
	@loader_path/QtScript.framework/Versions/4/QtScript48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libavutil.dylib"
sudo install_name_tool -change @loader_path/QtScript.framework/Versions/4/QtScript \
	@loader_path/QtScript.framework/Versions/4/QtScript48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpBatchIcePlugin.7.6.dylib"
sudo install_name_tool -change @loader_path/QtScript.framework/Versions/4/QtScript \
	@loader_path/QtScript.framework/Versions/4/QtScript48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpImarisBatchAgent.7.6.dylib"
sudo install_name_tool -change @loader_path/QtScript.framework/Versions/4/QtScript \
	@loader_path/QtScript.framework/Versions/4/QtScript48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpImarisGraphics.7.5.dylib"
sudo install_name_tool -change @loader_path/QtScript.framework/Versions/4/QtScript \
	@loader_path/QtScript.framework/Versions/4/QtScript48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpImarisStorage.7.5.dylib"
sudo install_name_tool -change @loader_path/QtScript.framework/Versions/4/QtScript \
	@loader_path/QtScript.framework/Versions/4/QtScript48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpcore.7.6.dylib"
sudo install_name_tool -change @loader_path/QtScript.framework/Versions/4/QtScript \
	@loader_path/QtScript.framework/Versions/4/QtScript48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpexception.7.6.dylib"
sudo install_name_tool -change @loader_path/QtScript.framework/Versions/4/QtScript \
	@loader_path/QtScript.framework/Versions/4/QtScript48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpfileio.7.6.dylib"
sudo install_name_tool -change @loader_path/QtScript.framework/Versions/4/QtScript \
	@loader_path/QtScript.framework/Versions/4/QtScript48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libexpat.1.dylib"
sudo install_name_tool -change @loader_path/QtScript.framework/Versions/4/QtScript \
	@loader_path/QtScript.framework/Versions/4/QtScript48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libfreeimage-3.15.0.dylib"
sudo install_name_tool -change @loader_path/QtScript.framework/Versions/4/QtScript \
	@loader_path/QtScript.framework/Versions/4/QtScript48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libhdf5.7.dylib"
sudo install_name_tool -change @loader_path/QtScript.framework/Versions/4/QtScript \
	@loader_path/QtScript.framework/Versions/4/QtScript48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libswscale.dylib"
###
sudo install_name_tool -change @loader_path/QtSql.framework/Versions/4/QtSql \
	@loader_path/QtSql.framework/Versions/4/QtSql48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libCg.2.1.dylib"
sudo install_name_tool -change @loader_path/QtSql.framework/Versions/4/QtSql \
	@loader_path/QtSql.framework/Versions/4/QtSql48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libCoin.60.dylib"
sudo install_name_tool -change @loader_path/QtSql.framework/Versions/4/QtSql \
	@loader_path/QtSql.framework/Versions/4/QtSql48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libIce.34.dylib"
sudo install_name_tool -change @loader_path/QtSql.framework/Versions/4/QtSql \
	@loader_path/QtSql.framework/Versions/4/QtSql48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libSBReadFile.dylib"
sudo install_name_tool -change @loader_path/QtSql.framework/Versions/4/QtSql \
	@loader_path/QtSql.framework/Versions/4/QtSql48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libSoQt.20.dylib"
sudo install_name_tool -change @loader_path/QtSql.framework/Versions/4/QtSql \
	@loader_path/QtSql.framework/Versions/4/QtSql48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libavcodec.dylib"
sudo install_name_tool -change @loader_path/QtSql.framework/Versions/4/QtSql \
	@loader_path/QtSql.framework/Versions/4/QtSql48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libavformat.dylib"
sudo install_name_tool -change @loader_path/QtSql.framework/Versions/4/QtSql \
	@loader_path/QtSql.framework/Versions/4/QtSql48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libavutil.dylib"
sudo install_name_tool -change @loader_path/QtSql.framework/Versions/4/QtSql \
	@loader_path/QtSql.framework/Versions/4/QtSql48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpBatchIcePlugin.7.6.dylib"
sudo install_name_tool -change @loader_path/QtSql.framework/Versions/4/QtSql \
	@loader_path/QtSql.framework/Versions/4/QtSql48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpImarisBatchAgent.7.6.dylib"
sudo install_name_tool -change @loader_path/QtSql.framework/Versions/4/QtSql \
	@loader_path/QtSql.framework/Versions/4/QtSql48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpImarisGraphics.7.5.dylib"
sudo install_name_tool -change @loader_path/QtSql.framework/Versions/4/QtSql \
	@loader_path/QtSql.framework/Versions/4/QtSql48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpImarisStorage.7.5.dylib"
sudo install_name_tool -change @loader_path/QtSql.framework/Versions/4/QtSql \
	@loader_path/QtSql.framework/Versions/4/QtSql48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpcore.7.6.dylib"
sudo install_name_tool -change @loader_path/QtSql.framework/Versions/4/QtSql \
	@loader_path/QtSql.framework/Versions/4/QtSql48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpexception.7.6.dylib"
sudo install_name_tool -change @loader_path/QtSql.framework/Versions/4/QtSql \
	@loader_path/QtSql.framework/Versions/4/QtSql48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpfileio.7.6.dylib"
sudo install_name_tool -change @loader_path/QtSql.framework/Versions/4/QtSql \
	@loader_path/QtSql.framework/Versions/4/QtSql48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libexpat.1.dylib"
sudo install_name_tool -change @loader_path/QtSql.framework/Versions/4/QtSql \
	@loader_path/QtSql.framework/Versions/4/QtSql48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libfreeimage-3.15.0.dylib"
sudo install_name_tool -change @loader_path/QtSql.framework/Versions/4/QtSql \
	@loader_path/QtSql.framework/Versions/4/QtSql48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libhdf5.7.dylib"
sudo install_name_tool -change @loader_path/QtSql.framework/Versions/4/QtSql \
	@loader_path/QtSql.framework/Versions/4/QtSql48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libswscale.dylib"
###
sudo install_name_tool -change @loader_path/QtSvg.framework/Versions/4/QtSvg \
	@loader_path/QtSvg.framework/Versions/4/QtSvg48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libCg.2.1.dylib"
sudo install_name_tool -change @loader_path/QtSvg.framework/Versions/4/QtSvg \
	@loader_path/QtSvg.framework/Versions/4/QtSvg48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libCoin.60.dylib"
sudo install_name_tool -change @loader_path/QtSvg.framework/Versions/4/QtSvg \
	@loader_path/QtSvg.framework/Versions/4/QtSvg48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libIce.34.dylib"
sudo install_name_tool -change @loader_path/QtSvg.framework/Versions/4/QtSvg \
	@loader_path/QtSvg.framework/Versions/4/QtSvg48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libSBReadFile.dylib"
sudo install_name_tool -change @loader_path/QtSvg.framework/Versions/4/QtSvg \
	@loader_path/QtSvg.framework/Versions/4/QtSvg48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libSoQt.20.dylib"
sudo install_name_tool -change @loader_path/QtSvg.framework/Versions/4/QtSvg \
	@loader_path/QtSvg.framework/Versions/4/QtSvg48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libavcodec.dylib"
sudo install_name_tool -change @loader_path/QtSvg.framework/Versions/4/QtSvg \
	@loader_path/QtSvg.framework/Versions/4/QtSvg48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libavformat.dylib"
sudo install_name_tool -change @loader_path/QtSvg.framework/Versions/4/QtSvg \
	@loader_path/QtSvg.framework/Versions/4/QtSvg48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libavutil.dylib"
sudo install_name_tool -change @loader_path/QtSvg.framework/Versions/4/QtSvg \
	@loader_path/QtSvg.framework/Versions/4/QtSvg48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpBatchIcePlugin.7.6.dylib"
sudo install_name_tool -change @loader_path/QtSvg.framework/Versions/4/QtSvg \
	@loader_path/QtSvg.framework/Versions/4/QtSvg48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpImarisBatchAgent.7.6.dylib"
sudo install_name_tool -change @loader_path/QtSvg.framework/Versions/4/QtSvg \
	@loader_path/QtSvg.framework/Versions/4/QtSvg48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpImarisGraphics.7.5.dylib"
sudo install_name_tool -change @loader_path/QtSvg.framework/Versions/4/QtSvg \
	@loader_path/QtSvg.framework/Versions/4/QtSvg48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpImarisStorage.7.5.dylib"
sudo install_name_tool -change @loader_path/QtSvg.framework/Versions/4/QtSvg \
	@loader_path/QtSvg.framework/Versions/4/QtSvg48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpcore.7.6.dylib"
sudo install_name_tool -change @loader_path/QtSvg.framework/Versions/4/QtSvg \
	@loader_path/QtSvg.framework/Versions/4/QtSvg48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpexception.7.6.dylib"
sudo install_name_tool -change @loader_path/QtSvg.framework/Versions/4/QtSvg \
	@loader_path/QtSvg.framework/Versions/4/QtSvg48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpfileio.7.6.dylib"
sudo install_name_tool -change @loader_path/QtSvg.framework/Versions/4/QtSvg \
	@loader_path/QtSvg.framework/Versions/4/QtSvg48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libexpat.1.dylib"
sudo install_name_tool -change @loader_path/QtSvg.framework/Versions/4/QtSvg \
	@loader_path/QtSvg.framework/Versions/4/QtSvg48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libfreeimage-3.15.0.dylib"
sudo install_name_tool -change @loader_path/QtSvg.framework/Versions/4/QtSvg \
	@loader_path/QtSvg.framework/Versions/4/QtSvg48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libhdf5.7.dylib"
sudo install_name_tool -change @loader_path/QtSvg.framework/Versions/4/QtSvg \
	@loader_path/QtSvg.framework/Versions/4/QtSvg48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libswscale.dylib"
###
sudo install_name_tool -change @loader_path/QtXml.framework/Versions/4/QtXml \
	@loader_path/QtXml.framework/Versions/4/QtXml48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libCg.2.1.dylib"
sudo install_name_tool -change @loader_path/QtXml.framework/Versions/4/QtXml \
	@loader_path/QtXml.framework/Versions/4/QtXml48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libCoin.60.dylib"
sudo install_name_tool -change @loader_path/QtXml.framework/Versions/4/QtXml \
	@loader_path/QtXml.framework/Versions/4/QtXml48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libIce.34.dylib"
sudo install_name_tool -change @loader_path/QtXml.framework/Versions/4/QtXml \
	@loader_path/QtXml.framework/Versions/4/QtXml48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libSBReadFile.dylib"
sudo install_name_tool -change @loader_path/QtXml.framework/Versions/4/QtXml \
	@loader_path/QtXml.framework/Versions/4/QtXml48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libSoQt.20.dylib"
sudo install_name_tool -change @loader_path/QtXml.framework/Versions/4/QtXml \
	@loader_path/QtXml.framework/Versions/4/QtXml48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libavcodec.dylib"
sudo install_name_tool -change @loader_path/QtXml.framework/Versions/4/QtXml \
	@loader_path/QtXml.framework/Versions/4/QtXml48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libavformat.dylib"
sudo install_name_tool -change @loader_path/QtXml.framework/Versions/4/QtXml \
	@loader_path/QtXml.framework/Versions/4/QtXml48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libavutil.dylib"
sudo install_name_tool -change @loader_path/QtXml.framework/Versions/4/QtXml \
	@loader_path/QtXml.framework/Versions/4/QtXml48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpBatchIcePlugin.7.6.dylib"
sudo install_name_tool -change @loader_path/QtXml.framework/Versions/4/QtXml \
	@loader_path/QtXml.framework/Versions/4/QtXml48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpImarisBatchAgent.7.6.dylib"
sudo install_name_tool -change @loader_path/QtXml.framework/Versions/4/QtXml \
	@loader_path/QtXml.framework/Versions/4/QtXml48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpImarisGraphics.7.5.dylib"
sudo install_name_tool -change @loader_path/QtXml.framework/Versions/4/QtXml \
	@loader_path/QtXml.framework/Versions/4/QtXml48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpImarisStorage.7.5.dylib"
sudo install_name_tool -change @loader_path/QtXml.framework/Versions/4/QtXml \
	@loader_path/QtXml.framework/Versions/4/QtXml48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpcore.7.6.dylib"
sudo install_name_tool -change @loader_path/QtXml.framework/Versions/4/QtXml \
	@loader_path/QtXml.framework/Versions/4/QtXml48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpexception.7.6.dylib"
sudo install_name_tool -change @loader_path/QtXml.framework/Versions/4/QtXml \
	@loader_path/QtXml.framework/Versions/4/QtXml48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpfileio.7.6.dylib"
sudo install_name_tool -change @loader_path/QtXml.framework/Versions/4/QtXml \
	@loader_path/QtXml.framework/Versions/4/QtXml48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libexpat.1.dylib"
sudo install_name_tool -change @loader_path/QtXml.framework/Versions/4/QtXml \
	@loader_path/QtXml.framework/Versions/4/QtXml48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libfreeimage-3.15.0.dylib"
sudo install_name_tool -change @loader_path/QtXml.framework/Versions/4/QtXml \
	@loader_path/QtXml.framework/Versions/4/QtXml48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libhdf5.7.dylib"
sudo install_name_tool -change @loader_path/QtXml.framework/Versions/4/QtXml \
	@loader_path/QtXml.framework/Versions/4/QtXml48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libswscale.dylib"
###
sudo install_name_tool -change @loader_path/QtXmlPatterns.framework/Versions/4/QtXmlPatterns \
	@loader_path/QtXmlPatterns.framework/Versions/4/QtXmlPatterns48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libCg.2.1.dylib"
sudo install_name_tool -change @loader_path/QtXmlPatterns.framework/Versions/4/QtXmlPatterns \
	@loader_path/QtXmlPatterns.framework/Versions/4/QtXmlPatterns48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libCoin.60.dylib"
sudo install_name_tool -change @loader_path/QtXmlPatterns.framework/Versions/4/QtXmlPatterns \
	@loader_path/QtXmlPatterns.framework/Versions/4/QtXmlPatterns48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libIce.34.dylib"
sudo install_name_tool -change @loader_path/QtXmlPatterns.framework/Versions/4/QtXmlPatterns \
	@loader_path/QtXmlPatterns.framework/Versions/4/QtXmlPatterns48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libSBReadFile.dylib"
sudo install_name_tool -change @loader_path/QtXmlPatterns.framework/Versions/4/QtXmlPatterns \
	@loader_path/QtXmlPatterns.framework/Versions/4/QtXmlPatterns48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libSoQt.20.dylib"
sudo install_name_tool -change @loader_path/QtXmlPatterns.framework/Versions/4/QtXmlPatterns \
	@loader_path/QtXmlPatterns.framework/Versions/4/QtXmlPatterns48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libavcodec.dylib"
sudo install_name_tool -change @loader_path/QtXmlPatterns.framework/Versions/4/QtXmlPatterns \
	@loader_path/QtXmlPatterns.framework/Versions/4/QtXmlPatterns48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libavformat.dylib"
sudo install_name_tool -change @loader_path/QtXmlPatterns.framework/Versions/4/QtXmlPatterns \
	@loader_path/QtXmlPatterns.framework/Versions/4/QtXmlPatterns48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libavutil.dylib"
sudo install_name_tool -change @loader_path/QtXmlPatterns.framework/Versions/4/QtXmlPatterns \
	@loader_path/QtXmlPatterns.framework/Versions/4/QtXmlPatterns48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpBatchIcePlugin.7.6.dylib"
sudo install_name_tool -change @loader_path/QtXmlPatterns.framework/Versions/4/QtXmlPatterns \
	@loader_path/QtXmlPatterns.framework/Versions/4/QtXmlPatterns48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpImarisBatchAgent.7.6.dylib"
sudo install_name_tool -change @loader_path/QtXmlPatterns.framework/Versions/4/QtXmlPatterns \
	@loader_path/QtXmlPatterns.framework/Versions/4/QtXmlPatterns48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpImarisGraphics.7.5.dylib"
sudo install_name_tool -change @loader_path/QtXmlPatterns.framework/Versions/4/QtXmlPatterns \
	@loader_path/QtXmlPatterns.framework/Versions/4/QtXmlPatterns48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpImarisStorage.7.5.dylib"
sudo install_name_tool -change @loader_path/QtXmlPatterns.framework/Versions/4/QtXmlPatterns \
	@loader_path/QtXmlPatterns.framework/Versions/4/QtXmlPatterns48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpcore.7.6.dylib"
sudo install_name_tool -change @loader_path/QtXmlPatterns.framework/Versions/4/QtXmlPatterns \
	@loader_path/QtXmlPatterns.framework/Versions/4/QtXmlPatterns48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpexception.7.6.dylib"
sudo install_name_tool -change @loader_path/QtXmlPatterns.framework/Versions/4/QtXmlPatterns \
	@loader_path/QtXmlPatterns.framework/Versions/4/QtXmlPatterns48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libbpfileio.7.6.dylib"
sudo install_name_tool -change @loader_path/QtXmlPatterns.framework/Versions/4/QtXmlPatterns \
	@loader_path/QtXmlPatterns.framework/Versions/4/QtXmlPatterns48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libexpat.1.dylib"
sudo install_name_tool -change @loader_path/QtXmlPatterns.framework/Versions/4/QtXmlPatterns \
	@loader_path/QtXmlPatterns.framework/Versions/4/QtXmlPatterns48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libfreeimage-3.15.0.dylib"
sudo install_name_tool -change @loader_path/QtXmlPatterns.framework/Versions/4/QtXmlPatterns \
	@loader_path/QtXmlPatterns.framework/Versions/4/QtXmlPatterns48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libhdf5.7.dylib"
sudo install_name_tool -change @loader_path/QtXmlPatterns.framework/Versions/4/QtXmlPatterns \
	@loader_path/QtXmlPatterns.framework/Versions/4/QtXmlPatterns48 \
	"/Applications/Imaris 7.6.0.app/Contents/Frameworks/libswscale.dylib"

# Change the references of other executables (in MacOS)
sudo install_name_tool -change \
	@executable_path/../Frameworks/QtCore.framework/Versions/4/QtCore \
	@executable_path/../Frameworks/QtCore.framework/Versions/4/QtCore48 \
	"/Applications/Imaris 7.6.0.app/Contents/MacOS/Imaris"
sudo install_name_tool -change \
	@executable_path/../Frameworks/QtDeclarative.framework/Versions/4/QtDeclarative \
	@executable_path/../Frameworks/QtDeclarative.framework/Versions/4/QtDeclarative48 \
	"/Applications/Imaris 7.6.0.app/Contents/MacOS/Imaris"
sudo install_name_tool -change \
	@executable_path/../Frameworks/QtGui.framework/Versions/4/QtGui \
	@executable_path/../Frameworks/QtGui.framework/Versions/4/QtGui48 \
	"/Applications/Imaris 7.6.0.app/Contents/MacOS/Imaris"
sudo install_name_tool -change \
	@executable_path/../Frameworks/QtNetwork.framework/Versions/4/QtNetwork \
	@executable_path/../Frameworks/QtNetwork.framework/Versions/4/QtNetwork48 \
	"/Applications/Imaris 7.6.0.app/Contents/MacOS/Imaris"
sudo install_name_tool -change \
	@executable_path/../Frameworks/QtOpenGL.framework/Versions/4/QtOpenGL \
	@executable_path/../Frameworks/QtOpenGL.framework/Versions/4/QtOpenGL48 \
	"/Applications/Imaris 7.6.0.app/Contents/MacOS/Imaris"
sudo install_name_tool -change \
	@executable_path/../Frameworks/QtScript.framework/Versions/4/QtScript \
	@executable_path/../Frameworks/QtScript.framework/Versions/4/QtScript48 \
	"/Applications/Imaris 7.6.0.app/Contents/MacOS/Imaris"
sudo install_name_tool -change \
	@executable_path/../Frameworks/QtSql.framework/Versions/4/QtSql \
	@executable_path/../Frameworks/QtSql.framework/Versions/4/QtSql48 \
	"/Applications/Imaris 7.6.0.app/Contents/MacOS/Imaris"
sudo install_name_tool -change \
	@executable_path/../Frameworks/QtSvg.framework/Versions/4/QtSvg \
	@executable_path/../Frameworks/QtSvg.framework/Versions/4/QtSvg48 \
	"/Applications/Imaris 7.6.0.app/Contents/MacOS/Imaris"
sudo install_name_tool -change \
	@executable_path/../Frameworks/QtXml.framework/Versions/4/QtXml \
	@executable_path/../Frameworks/QtXml.framework/Versions/4/QtXml48 \
	"/Applications/Imaris 7.6.0.app/Contents/MacOS/Imaris"
sudo install_name_tool -change \
	@executable_path/../Frameworks/QtXmlPatterns.framework/Versions/4/QtXmlPatterns \
	@executable_path/../Frameworks/QtXmlPatterns.framework/Versions/4/QtXmlPatterns48 \
	"/Applications/Imaris 7.6.0.app/Contents/MacOS/Imaris"
