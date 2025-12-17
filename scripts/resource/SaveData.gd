extends FileAccess

const ENDERECO:String = "res://data/Time.json"
const DEFAULT:Dictionary = {"Hora": "0", "Minutos": "00"}

static func saveTempo(tempo:Dictionary) -> void:
	#Reescreve o conteudo do ficheiro
	var ficheiro:FileAccess = FileAccess.open(ENDERECO, FileAccess.WRITE_READ)
	tempo["Hora"] = str(tempo["Hora"])
	tempo["Minutos"] = "00" if tempo["Minutos"] == 0 else str(tempo["Minutos"])
	ficheiro.store_string(str(tempo))
	
static func getTempo() -> Dictionary:
	if !FileAccess.file_exists(ENDERECO):
		saveTempo(DEFAULT)
		return DEFAULT
		
	var dicionarioString:String = FileAccess.get_file_as_string(ENDERECO)
	if dicionarioString.is_empty():
		saveTempo(DEFAULT)
		return DEFAULT
		
	#Transforma o dicionario-string para dicionario
	return JSON.parse_string(dicionarioString)
