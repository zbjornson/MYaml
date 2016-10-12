YAML importer for *Mathematica*.

### Installation

This snippet will install the converter in the `$BaseDirectory`. (You may also
use `$UserBaseDirectory` instead.) After installation, the format will be
available like any other importer.

```Mathematica
tmp = URLSave["https://github.com/zbjornson/MYaml/archive/master.zip"];
dest = FileNameJoin[{$BaseDirectory, "SystemFiles", "Formats"}];
Quiet[CreateDirectory[dest]];
ExtractArchive[tmp, dest];
RenameDirectory[FileNameJoin[{dest, "MYaml-master"}], FileNameJoin[{dest, "YAML"}]];
DeleteFile[tmp];
Print["Installed YAML importer to " <> dest <> ". Please restart Mathematica or the kernel."]
```

### Usage

Note that the format must be specified when calling `Import` ([note](#extension-detection)).

```Mathematica
Import["filename.yaml", "YAML"]
```

### YAML Spec Compliance

This library is a thin binding to [SnakeYAML](https://bitbucket.org/asomov/snakeyaml),
which is a complete YAML 1.1 processor.

* All [language-independent types](http://www.yaml.org/type/) are supported.
* Only single documents are supported; multiple documents separated by "---"
  are not supported.
* Recursive references are not supported; these will currently cause
  a stack overflow.
* *Mathematica* does not have distinct types corresponding to all of the YAML
  collection types (unordered vs. ordered maps, allowing vs. disallowing
  duplicates; sets vs. plain lists). All of the collections are imported as
  `List`s, and all `List`s are exported as `!!seq` (sequences).

### Developer Notes

The `YAML` directory is what gets copied to `$[User]BaseDirectory/SystemFiles/Formats`.
All other files and folders are only needed for testing and building from source.

### Extension Detection

I can't quite get *Mathematica* to automatically import "*.yaml" files as YAML.
You could put the following code in an `init.m` file; it does not seem to load
properly when placed in the importer source code.

```Mathematica
Unprotect[Import];
Import[name_String, opts___?OptionQ] := 
  Import[name, "YAML", opts] /; 
   ToLowerCase[FileExtension[name]] === "yaml";
Protect[Import];
```
