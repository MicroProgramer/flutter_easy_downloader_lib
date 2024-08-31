import 'dart:io';

import 'package:easy_downloader/easy_downloader.dart';

void main() async {
  var file = File("test.mp4");
  if (file.existsSync()) {
    file.deleteSync();
  }
  await Isar.initializeIsarCore(download: true);
  var isar = await Isar.open(EasyDownloader.schemas, directory: ".");
  var easyDownloader = await EasyDownloader().init(isar: isar);
  var dir = Directory("download");
  if (dir.existsSync()) {
    dir.deleteSync(recursive: true);
  }
  // print(await easyDownloader.allDownloadTasks());
  // return;
  var task = await easyDownloader.download(
    url:
        "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4",
    maxSplit: 10,
  );
  task.addListener((task) {
    print(
        "status: ${task.status} ${task.totalDownloaded.toHumanReadableSize()} / ${task.totalLength.toHumanReadableSize()}");
  });

  task.start();
}
