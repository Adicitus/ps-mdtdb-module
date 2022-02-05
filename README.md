# MDTDatabase
This module consists of original work by Michael Neihaus (See [Michael's original blog post](https://blogs.technet.microsoft.com/mniehaus/2009/05/14/manipulating-the-microsoft-deployment-toolkit-database-using-powershell/)), and is intended to make the module available on PSGallery for anyone still
using the Microsoft Deployment Toolkit.

Code courtesy of [Vaughn Miller](https://github.com/vmiller/MDT-Database-script) since the script is no longer available from the blog post.

## How to use these files
Use the Build-ModuleProject from the PSBuildModule to build a module from the files in the Source directory, then import the module into you project.

```
git clone https://github.com/Adicitus/ps-mdtdb-module.git
Build-ModuleProject ./ps-mdtdb-module
Import-Module ./ps-mdtdb-module/out/MDTDatabase/MDTDatabase.psm1
```

## How to install the module
You can install the module from PSGallery: `Install-Module MDTDatabase`
