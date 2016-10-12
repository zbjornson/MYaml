Begin["System`Convert`YAMLDump`"]

ImportExport`RegisterImport[
	"YAML",
	importYAML,
	"Sources" -> {"JLink`", FileNameJoin[{DirectoryName[$InputFileName], "Converter.m"}]},
	"AvailableElements" -> {"Data"},
	"DefaultElement" -> "Data",
	"FunctionChannels" -> {"FileNames"}
]

End[]
