# OpenRocket-Files

This repository is set up with hooks to allow git to work with .ork files properly

## How to use this repository
* Setup
  * Run the setup script for your system: on Windows, double-click `setup.bat`; on MacOS and Linux, run `setup.sh`
* Commiting changes
  * This process might break if you have spaces in filenames or subdirectories, it hasn't been tested. So maybe just avoid spaces. Or fix my hooks, that'd be cool too.
  * `git add` and `git commit` as usual. The system will actually make two commits for you, but you don't need to worry about that.
* Pulling from the remote
  * `git pull` as usual. Uncommitted changes in your local directory may be overwritten.
* Don't edit the `.archive` folder (though make sure it's included in the second commit)

## How this works
OpenRocket files (.ork files) are binary files: they're just a bunch of bytes. This is fine, but git can't properly track changes with binary files. If all you do is change the mass of the nosecone, git won't be able to identify that was the change. All it can do is call your change a whole new version of the file. Also, if two people work on different parts of the same file, they won't be able to merge it in git. 

How exactly do .ork files work? There is actually a core XML file (which is text-based, and easy for git to track) as part of each .ork file. However, a single .ork file might include other things, like data files or images, and while you could let each OpenRocket model be a folder containing both the XML and the data/images, it's a lot nicer for a single OpenRocket model to be a single file. To accomplish this, that folder is just zipped up into a .zip file, except the extension is .ork.

So, for git to track changes in .ork files properly, we would need to un-zip the files before commiting, then after pulling, re-zip them. This would be super tedious to do by hand, so we can have git do it for us. git has "hooks", which are just programs you can write and they're run automatically at certain points. I've written a "pre-commit" hook that does the unzipping, and re-commiting with the unzipped files, and a "post-merge" hook to re-zip the .ork files. (There's no post-pull hook, but a pull is just a merge after a fetch.) If you want to tinker around with these scripts, they're in the hooks directory. The setup script copies the scripts into the location where git looks for them (`.git/hooks`).
