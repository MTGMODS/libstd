local ffi = require "ffi"

pcall(ffi.cdef, [[
	const char* NeoMLoader_GetBassPath();
	void* NeoMLoader_GetBassSymbol(const char* symName);
]])
local cdef_loaded = false
pcall(function()
	if ffi.typeof("struct _GUID") ~= nil then
		cdef_loaded = true
	end
end)

if not cdef_loaded then
ffi.cdef([[
	typedef void *PVOID;
	typedef PVOID HANDLE;
	typedef HANDLE HWND;
	typedef uint8_t BYTE;
	typedef uint16_t WORD;
	typedef uint32_t DWORD;
	typedef uint64_t QWORD;
	typedef int BOOL;

	typedef struct _GUID {
		DWORD Data1;
		WORD  Data2;
		WORD  Data3;
		BYTE  Data4[8];
	} GUID;

	typedef DWORD HMUSIC;		// MOD music handle
	typedef DWORD HSAMPLE;		// sample handle
	typedef DWORD HCHANNEL;		// playing sample's channel handle
	typedef DWORD HSTREAM;		// sample stream handle
	typedef DWORD HRECORD;		// recording handle
	typedef DWORD HSYNC;		// synchronizer handle
	typedef DWORD HDSP;			// DSP handle
	typedef DWORD HFX;			// DX8 effect handle
	typedef DWORD HPLUGIN;		// Plugin handle

	typedef struct {
		const char *name;	// description
		const char *driver;	// driver
		DWORD flags;
	} BASS_DEVICEINFO;

	typedef struct {
		DWORD flags;	// device capabilities (DSCAPS_xxx flags)
		DWORD hwsize;	// size of total device hardware memory
		DWORD hwfree;	// size of free device hardware memory
		DWORD freesam;	// number of free sample slots in the hardware
		DWORD free3d;	// number of free 3D sample slots in the hardware
		DWORD minrate;	// min sample rate supported by the hardware
		DWORD maxrate;	// max sample rate supported by the hardware
		BOOL eax;		// device supports EAX? (always FALSE if BASS_DEVICE_3D was not used)
		DWORD minbuf;	// recommended minimum buffer length in ms (requires BASS_DEVICE_LATENCY)
		DWORD dsver;	// DirectSound version
		DWORD latency;	// delay (in ms) before start of playback (requires BASS_DEVICE_LATENCY)
		DWORD initflags; // BASS_Init "flags" parameter
		DWORD speakers; // number of speakers available
		DWORD freq;		// current output rate
	} BASS_INFO;

	// Recording device info structure
	typedef struct {
		DWORD flags;	// device capabilities (DSCCAPS_xxx flags)
		DWORD formats;	// supported standard formats (WAVE_FORMAT_xxx flags)
		DWORD inputs;	// number of inputs
		BOOL singlein;	// TRUE = only 1 input can be set at a time
		DWORD freq;		// current input rate
	} BASS_RECORDINFO;

	typedef struct {
		DWORD freq;		// default playback rate
		float volume;	// default volume (0-1)
		float pan;		// default pan (-1=left, 0=middle, 1=right)
		DWORD flags;	// BASS_SAMPLE_xxx flags
		DWORD length;	// length (in bytes)
		DWORD max;		// maximum simultaneous playbacks
		DWORD origres;	// original resolution bits
		DWORD chans;	// number of channels
		DWORD mingap;	// minimum gap (ms) between creating channels
		DWORD mode3d;	// BASS_3DMODE_xxx mode
		float mindist;	// minimum distance
		float maxdist;	// maximum distance
		DWORD iangle;	// angle of inside projection cone
		DWORD oangle;	// angle of outside projection cone
		float outvol;	// delta-volume outside the projection cone
		DWORD vam;		// voice allocation/management flags (BASS_VAM_xxx)
		DWORD priority;	// priority (0=lowest, 0xffffffff=highest)
	} BASS_SAMPLE;

	typedef struct {
		DWORD freq;		// default playback rate
		DWORD chans;	// channels
		DWORD flags;	// BASS_SAMPLE/STREAM/MUSIC/SPEAKER flags
		DWORD ctype;	// type of channel
		DWORD origres;	// original resolution
		HPLUGIN plugin;	// plugin
		HSAMPLE sample; // sample
		const char *filename; // filename
	} BASS_CHANNELINFO;

	typedef struct {
		DWORD ctype;		// channel type
		const char *name;	// format description
		const char *exts;	// file extension filter (*.ext1;*.ext2;etc...)
	} BASS_PLUGINFORM;

	typedef struct {
		DWORD version;					// version (same form as BASS_GetVersion)
		DWORD formatc;					// number of formats
		const BASS_PLUGINFORM *formats;	// the array of formats
	} BASS_PLUGININFO;

	// 3D vector (for 3D positions/velocities/orientations)
	typedef struct BASS_3DVECTOR {
		float x;	// +=right, -=left
		float y;	// +=up, -=down
		float z;	// +=front, -=behind
	} BASS_3DVECTOR;

	enum
	{
		EAX_ENVIRONMENT_GENERIC,
		EAX_ENVIRONMENT_PADDEDCELL,
		EAX_ENVIRONMENT_ROOM,
		EAX_ENVIRONMENT_BATHROOM,
		EAX_ENVIRONMENT_LIVINGROOM,
		EAX_ENVIRONMENT_STONEROOM,
		EAX_ENVIRONMENT_AUDITORIUM,
		EAX_ENVIRONMENT_CONCERTHALL,
		EAX_ENVIRONMENT_CAVE,
		EAX_ENVIRONMENT_ARENA,
		EAX_ENVIRONMENT_HANGAR,
		EAX_ENVIRONMENT_CARPETEDHALLWAY,
		EAX_ENVIRONMENT_HALLWAY,
		EAX_ENVIRONMENT_STONECORRIDOR,
		EAX_ENVIRONMENT_ALLEY,
		EAX_ENVIRONMENT_FOREST,
		EAX_ENVIRONMENT_CITY,
		EAX_ENVIRONMENT_MOUNTAINS,
		EAX_ENVIRONMENT_QUARRY,
		EAX_ENVIRONMENT_PLAIN,
		EAX_ENVIRONMENT_PARKINGLOT,
		EAX_ENVIRONMENT_SEWERPIPE,
		EAX_ENVIRONMENT_UNDERWATER,
		EAX_ENVIRONMENT_DRUGGED,
		EAX_ENVIRONMENT_DIZZY,
		EAX_ENVIRONMENT_PSYCHOTIC,

		EAX_ENVIRONMENT_COUNT			// total number of environments
	};

	typedef DWORD (STREAMPROC)(HSTREAM handle, void *buffer, DWORD length, void *user);
	/* User stream callback function. NOTE: A stream function should obviously be as quick
	as possible, other streams (and MOD musics) can't be mixed until it's finished.
	handle : The stream that needs writing
	buffer : Buffer to write the samples in
	length : Number of bytes to write
	user   : The 'user' parameter value given when calling BASS_StreamCreate
	RETURN : Number of bytes written. Set the BASS_STREAMPROC_END flag to end
			 the stream. */

	 // User file stream callback functions
	typedef void (FILECLOSEPROC)(void *user);
	typedef QWORD (FILELENPROC)(void *user);
	typedef DWORD (FILEREADPROC)(void *buffer, DWORD length, void *user);
	typedef BOOL (FILESEEKPROC)(QWORD offset, void *user);

	typedef struct {
		FILECLOSEPROC *close;
		FILELENPROC *length;
		FILEREADPROC *read;
		FILESEEKPROC *seek;
	} BASS_FILEPROCS;

	typedef void (DOWNLOADPROC)(const void *buffer, DWORD length, void *user);

	typedef void (SYNCPROC)(HSYNC handle, DWORD channel, DWORD data, void *user);
	/* Sync callback function. NOTE: a sync callback function should be very
	quick as other syncs can't be processed until it has finished. If the sync
	is a "mixtime" sync, then other streams and MOD musics can't be mixed until
	it's finished either.
	handle : The sync that has occured
	channel: Channel that the sync occured in
	data   : Additional data associated with the sync's occurance
	user   : The 'user' parameter given when calling BASS_ChannelSetSync */

	typedef void (DSPPROC)(HDSP handle, DWORD channel, void *buffer, DWORD length, void *user);
	/* DSP callback function. NOTE: A DSP function should obviously be as quick as
	possible... other DSP functions, streams and MOD musics can not be processed
	until it's finished.
	handle : The DSP handle
	channel: Channel that the DSP is being applied to
	buffer : Buffer to apply the DSP to
	length : Number of bytes in the buffer
	user   : The 'user' parameter given when calling BASS_ChannelSetDSP */

	typedef BOOL (RECORDPROC)(HRECORD handle, const void *buffer, DWORD length, void *user);
	/* Recording callback function.
	handle : The recording handle
	buffer : Buffer containing the recorded sample data
	length : Number of bytes
	user   : The 'user' parameter value given when calling BASS_RecordStart
	RETURN : TRUE = continue recording, FALSE = stop */

	// ID3v1 tag structure
	typedef struct {
		char id[3];
		char title[30];
		char artist[30];
		char album[30];
		char year[4];
		char comment[30];
		BYTE genre;
	} TAG_ID3;

	// Binary APE tag structure
	typedef struct {
		const char *key;
		const void *data;
		DWORD length;
	} TAG_APE_BINARY;

	#pragma pack(push,1)
	typedef struct {
		char Description[256];			// description
		char Originator[32];			// name of the originator
		char OriginatorReference[32];	// reference of the originator
		char OriginationDate[10];		// date of creation (yyyy-mm-dd)
		char OriginationTime[8];		// time of creation (hh-mm-ss)
		QWORD TimeReference;			// first sample count since midnight (little-endian)
		WORD Version;					// BWF version (little-endian)
		BYTE UMID[64];					// SMPTE UMID
		BYTE Reserved[190];
		char CodingHistory[1];			// history
	} TAG_BEXT;
	#pragma pack(pop)

	// BWF "cart" tag structures
	typedef struct
	{
		DWORD dwUsage;					// FOURCC timer usage ID
		DWORD dwValue;					// timer value in samples from head
	} TAG_CART_TIMER;

	typedef struct
	{
		char Version[4];				// version of the data structure
		char Title[64];					// title of cart audio sequence
		char Artist[64];				// artist or creator name
		char CutID[64];					// cut number identification
		char ClientID[64];				// client identification
		char Category[64];				// category ID, PSA, NEWS, etc
		char Classification[64];		// classification or auxiliary key
		char OutCue[64];				// out cue text
		char StartDate[10];				// yyyy-mm-dd
		char StartTime[8];				// hh:mm:ss
		char EndDate[10];				// yyyy-mm-dd
		char EndTime[8];				// hh:mm:ss
		char ProducerAppID[64];			// name of vendor or application
		char ProducerAppVersion[64];	// version of producer application
		char UserDef[64];				// user defined text
		DWORD dwLevelReference;			// sample value for 0 dB reference
		TAG_CART_TIMER PostTimer[8];	// 8 time markers after head
		char Reserved[276];
		char URL[1024];					// uniform resource locator
		char TagText[1];				// free form text for scripts or tags
	} TAG_CART;

	// CoreAudio codec info structure
	typedef struct {
		DWORD ftype;					// file format
		DWORD atype;					// audio format
		const char *name;				// description
	} TAG_CA_CODEC;

	BOOL BASS_SetConfig(DWORD option, DWORD value);
	DWORD BASS_GetConfig(DWORD option);
	BOOL BASS_SetConfigPtr(DWORD option, const void *value);
	void *BASS_GetConfigPtr(DWORD option);
	DWORD BASS_GetVersion();
	int BASS_ErrorGetCode();
	BOOL BASS_GetDeviceInfo(DWORD device, BASS_DEVICEINFO *info);
	BOOL BASS_Init(int device, DWORD freq, DWORD flags, void *win, void *dsguid);
	BOOL BASS_SetDevice(DWORD device);
	DWORD BASS_GetDevice();
	BOOL BASS_Free();
	void *BASS_GetDSoundObject(DWORD object);
	BOOL BASS_GetInfo(BASS_INFO *info);
	BOOL BASS_Update(DWORD length);
	float BASS_GetCPU();
	BOOL BASS_Start();
	BOOL BASS_Stop();
	BOOL BASS_Pause();
	BOOL BASS_SetVolume(float volume);
	float BASS_GetVolume();

	HPLUGIN BASS_PluginLoad(const char *file, DWORD flags);
	BOOL BASS_PluginFree(HPLUGIN handle);
	const BASS_PLUGININFO *BASS_PluginGetInfo(HPLUGIN handle);

	BOOL BASS_Set3DFactors(float distf, float rollf, float doppf);
	BOOL BASS_Get3DFactors(float *distf, float *rollf, float *doppf);
	BOOL BASS_Set3DPosition(const BASS_3DVECTOR *pos, const BASS_3DVECTOR *vel, const BASS_3DVECTOR *front, const BASS_3DVECTOR *top);
	BOOL BASS_Get3DPosition(BASS_3DVECTOR *pos, BASS_3DVECTOR *vel, BASS_3DVECTOR *front, BASS_3DVECTOR *top);
	void BASS_Apply3D();
	BOOL BASS_SetEAXParameters(int env, float vol, float decay, float damp);
	BOOL BASS_GetEAXParameters(DWORD *env, float *vol, float *decay, float *damp);

	HMUSIC BASS_MusicLoad(BOOL mem, const void *file, QWORD offset, DWORD length, DWORD flags, DWORD freq);
	BOOL BASS_MusicFree(HMUSIC handle);

	HSAMPLE BASS_SampleLoad(BOOL mem, const void *file, QWORD offset, DWORD length, DWORD max, DWORD flags);
	HSAMPLE BASS_SampleCreate(DWORD length, DWORD freq, DWORD chans, DWORD max, DWORD flags);
	BOOL BASS_SampleFree(HSAMPLE handle);
	BOOL BASS_SampleSetData(HSAMPLE handle, const void *buffer);
	BOOL BASS_SampleGetData(HSAMPLE handle, void *buffer);
	BOOL BASS_SampleGetInfo(HSAMPLE handle, BASS_SAMPLE *info);
	BOOL BASS_SampleSetInfo(HSAMPLE handle, const BASS_SAMPLE *info);
	HCHANNEL BASS_SampleGetChannel(HSAMPLE handle, BOOL onlynew);
	DWORD BASS_SampleGetChannels(HSAMPLE handle, HCHANNEL *channels);
	BOOL BASS_SampleStop(HSAMPLE handle);

	HSTREAM BASS_StreamCreate(DWORD freq, DWORD chans, DWORD flags, STREAMPROC *proc, void *user);
	HSTREAM BASS_StreamCreateFile(BOOL mem, const void *file, QWORD offset, QWORD length, DWORD flags);
	HSTREAM BASS_StreamCreateURL(const char *url, DWORD offset, DWORD flags, DOWNLOADPROC *proc, void *user);
	HSTREAM BASS_StreamCreateFileUser(DWORD system, DWORD flags, const BASS_FILEPROCS *proc, void *user);
	HSTREAM BASS_Mixer_StreamCreate(DWORD freq, DWORD chans, DWORD flags);
	BOOL BASS_Mixer_StreamAddChannel(HSTREAM handle, DWORD channel, DWORD flags);
	BOOL BASS_StreamFree(HSTREAM handle);
	QWORD BASS_StreamGetFilePosition(HSTREAM handle, DWORD mode);
	DWORD BASS_StreamPutData(HSTREAM handle, const void *buffer, DWORD length);
	DWORD BASS_StreamPutFileData(HSTREAM handle, const void *buffer, DWORD length);

	BOOL BASS_RecordGetDeviceInfo(DWORD device, BASS_DEVICEINFO *info);
	BOOL BASS_RecordInit(int device);
	BOOL BASS_RecordSetDevice(DWORD device);
	DWORD BASS_RecordGetDevice();
	BOOL BASS_RecordFree();
	BOOL BASS_RecordGetInfo(BASS_RECORDINFO *info);
	const char *BASS_RecordGetInputName(int input);
	BOOL BASS_RecordSetInput(int input, DWORD flags, float volume);
	DWORD BASS_RecordGetInput(int input, float *volume);
	HRECORD BASS_RecordStart(DWORD freq, DWORD chans, DWORD flags, RECORDPROC *proc, void *user);

	double BASS_ChannelBytes2Seconds(DWORD handle, QWORD pos);
	QWORD BASS_ChannelSeconds2Bytes(DWORD handle, double pos);
	DWORD BASS_ChannelGetDevice(DWORD handle);
	BOOL BASS_ChannelSetDevice(DWORD handle, DWORD device);
	DWORD BASS_ChannelIsActive(DWORD handle);
	BOOL BASS_ChannelGetInfo(DWORD handle, BASS_CHANNELINFO *info);
	const char *BASS_ChannelGetTags(DWORD handle, DWORD tags);
	DWORD BASS_ChannelFlags(DWORD handle, DWORD flags, DWORD mask);
	BOOL BASS_ChannelUpdate(DWORD handle, DWORD length);
	BOOL BASS_ChannelLock(DWORD handle, BOOL lock);
	BOOL BASS_ChannelPlay(DWORD handle, BOOL restart);
	BOOL BASS_ChannelStop(DWORD handle);
	BOOL BASS_ChannelPause(DWORD handle);
	BOOL BASS_ChannelSetAttribute(DWORD handle, DWORD attrib, float value);
	BOOL BASS_ChannelGetAttribute(DWORD handle, DWORD attrib, float *value);
	BOOL BASS_ChannelSlideAttribute(DWORD handle, DWORD attrib, float value, DWORD time);
	BOOL BASS_ChannelIsSliding(DWORD handle, DWORD attrib);
	BOOL BASS_ChannelSetAttributeEx(DWORD handle, DWORD attrib, void *value, DWORD size);
	DWORD BASS_ChannelGetAttributeEx(DWORD handle, DWORD attrib, void *value, DWORD size);
	BOOL BASS_ChannelSet3DAttributes(DWORD handle, int mode, float min, float max, int iangle, int oangle, float outvol);
	BOOL BASS_ChannelGet3DAttributes(DWORD handle, DWORD *mode, float *min, float *max, DWORD *iangle, DWORD *oangle, float *outvol);
	BOOL BASS_ChannelSet3DPosition(DWORD handle, const BASS_3DVECTOR *pos, const BASS_3DVECTOR *orient, const BASS_3DVECTOR *vel);
	BOOL BASS_ChannelGet3DPosition(DWORD handle, BASS_3DVECTOR *pos, BASS_3DVECTOR *orient, BASS_3DVECTOR *vel);
	QWORD BASS_ChannelGetLength(DWORD handle, DWORD mode);
	BOOL BASS_ChannelSetPosition(DWORD handle, QWORD pos, DWORD mode);
	QWORD BASS_ChannelGetPosition(DWORD handle, DWORD mode);
	DWORD BASS_ChannelGetLevel(DWORD handle);
	BOOL BASS_ChannelGetLevelEx(DWORD handle, float *levels, float length, DWORD flags);
	DWORD BASS_ChannelGetData(DWORD handle, void *buffer, DWORD length);
	HSYNC BASS_ChannelSetSync(DWORD handle, DWORD type, QWORD param, SYNCPROC *proc, void *user);
	BOOL BASS_ChannelRemoveSync(DWORD handle, HSYNC sync);
	HDSP BASS_ChannelSetDSP(DWORD handle, DSPPROC *proc, void *user, int priority);
	BOOL BASS_ChannelRemoveDSP(DWORD handle, HDSP dsp);
	BOOL BASS_ChannelSetLink(DWORD handle, DWORD chan);
	BOOL BASS_ChannelRemoveLink(DWORD handle, DWORD chan);
	HFX BASS_ChannelSetFX(DWORD handle, DWORD type, int priority);
	BOOL BASS_ChannelRemoveFX(DWORD handle, HFX fx);

	BOOL BASS_FXSetParameters(HFX handle, const void *params);
	BOOL BASS_FXGetParameters(HFX handle, void *params);
	BOOL BASS_FXReset(HFX handle);
]])
end

local candidates = {}

pcall(function()
	local p = ffi.C.NeoMLoader_GetBassPath()
	if p ~= nil then
		local s = ffi.string(p)
		if #s > 0 then table.insert(candidates, s) end
	end
end)

local function scan_maps_for_bass()
	local f = io.open("/proc/self/maps", "r")
	if not f then return nil end
	for line in f:lines() do
		local path = line:match("%s+(/.-libbass.-%.so.*)$") or line:match("%s+(/.-bass.-%.so.*)$")
		if path and not path:find("NeoMLoader") then
			local clean = path:match("^([^%s!]+)")
			if clean and clean:find("%.so$") then
				f:close()
				return clean
			end
		end
	end
	f:close()
	return nil
end

local maps_path = scan_maps_for_bass()
if maps_path then
	table.insert(candidates, maps_path)
end

table.insert(candidates, "libbass.so")
table.insert(candidates, "bass")
table.insert(candidates, "libbass")

if type(getWorkingDirectory) == "function" then
	local wd = getWorkingDirectory()
	table.insert(candidates, wd .. "/lib/libbass.so")
	table.insert(candidates, wd .. "/libbass.so")
	table.insert(candidates, wd .. "/lib/bass.so")
end

local raw_bass = nil
for _, path in ipairs(candidates) do
	local ok, lib = pcall(ffi.load, path)
	if ok and lib then
		raw_bass = lib
		break
	end
end

local has_ffi_c = false
pcall(function()
	if ffi.C.BASS_Init ~= nil then
		has_ffi_c = true
	end
end)

local has_nml_sym = false
pcall(function()
	if ffi.C.NeoMLoader_GetBassSymbol ~= nil then
		has_nml_sym = true
	end
end)

local modname = ...
if not raw_bass and not has_ffi_c and not has_nml_sym then
	if modname then
		package.loaded[modname] = false
	end
	return nil
end

local fn_types = {
	BASS_Init = "BOOL (*)(int, DWORD, DWORD, void*, void*)",
	BASS_Free = "BOOL (*)()",
	BASS_StreamCreateURL = "HSTREAM (*)(const char*, DWORD, DWORD, DOWNLOADPROC*, void*)",
	BASS_StreamCreateFile = "HSTREAM (*)(BOOL, const void*, QWORD, QWORD, DWORD)",
	BASS_StreamFree = "BOOL (*)(HSTREAM)",
	BASS_ChannelPlay = "BOOL (*)(DWORD, BOOL)",
	BASS_ChannelStop = "BOOL (*)(DWORD)",
	BASS_ChannelPause = "BOOL (*)(DWORD)",
	BASS_ChannelIsActive = "DWORD (*)(DWORD)",
	BASS_ChannelSetAttribute = "BOOL (*)(DWORD, DWORD, float)",
	BASS_ChannelGetAttribute = "BOOL (*)(DWORD, DWORD, float*)",
	BASS_ChannelSetPosition = "BOOL (*)(DWORD, QWORD, DWORD)",
	BASS_ChannelGetPosition = "QWORD (*)(DWORD, DWORD)",
	BASS_ChannelGetLength = "QWORD (*)(DWORD, DWORD)",
	BASS_ChannelBytes2Seconds = "double (*)(DWORD, QWORD)",
	BASS_ChannelSeconds2Bytes = "QWORD (*)(DWORD, double)",
	BASS_ChannelSetSync = "HSYNC (*)(DWORD, DWORD, QWORD, SYNCPROC*, void*)",
	BASS_ChannelRemoveSync = "BOOL (*)(DWORD, HSYNC)",
	BASS_ChannelSet3DPosition = "BOOL (*)(DWORD, const BASS_3DVECTOR*, const BASS_3DVECTOR*, const BASS_3DVECTOR*)",
	BASS_ChannelGet3DPosition = "BOOL (*)(DWORD, BASS_3DVECTOR*, BASS_3DVECTOR*, BASS_3DVECTOR*)",
	BASS_ChannelGetData = "DWORD (*)(DWORD, void*, DWORD)",
	BASS_ChannelGetLevel = "DWORD (*)(DWORD)",
	BASS_ChannelGetInfo = "BOOL (*)(DWORD, BASS_CHANNELINFO*)",
	BASS_ChannelFlags = "DWORD (*)(DWORD, DWORD, DWORD)",
	BASS_ChannelUpdate = "BOOL (*)(DWORD, DWORD)",
	BASS_ChannelLock = "BOOL (*)(DWORD, BOOL)",
	BASS_ErrorGetCode = "int (*)()",
	BASS_GetVersion = "DWORD (*)()",
	BASS_GetDevice = "DWORD (*)()",
	BASS_SetDevice = "BOOL (*)(DWORD)",
	BASS_GetDeviceInfo = "BOOL (*)(DWORD, BASS_DEVICEINFO*)",
	BASS_GetInfo = "BOOL (*)(BASS_INFO*)",
	BASS_Start = "BOOL (*)()",
	BASS_Stop = "BOOL (*)()",
	BASS_Pause = "BOOL (*)()",
	BASS_SetVolume = "BOOL (*)(float)",
	BASS_GetVolume = "float (*)()",
	BASS_GetCPU = "float (*)()",
	BASS_Update = "BOOL (*)(DWORD)",
	BASS_SetConfig = "BOOL (*)(DWORD, DWORD)",
	BASS_GetConfig = "DWORD (*)(DWORD)",
	BASS_SetConfigPtr = "BOOL (*)(DWORD, const void*)",
	BASS_GetConfigPtr = "void* (*)(DWORD)",
}

local bass = {}
local bass_mt = {
	__index = function(self, k)
		if raw_bass then
			local ok, val = pcall(function() return raw_bass[k] end)
			if ok and val ~= nil then
				rawset(self, k, val)
				return val
			end
		end

		local ok_c, val_c = pcall(function() return ffi.C[k] end)
		if ok_c and val_c ~= nil then
			rawset(self, k, val_c)
			return val_c
		end

		if has_nml_sym then
			local ok_sym, ptr = pcall(ffi.C.NeoMLoader_GetBassSymbol, k)
			if ok_sym and ptr ~= nil and ptr ~= ffi.cast("void*", 0) then
				local cast_sig = fn_types[k]
				local callable = ptr
				if cast_sig then
					local ok_cast, cfn = pcall(ffi.cast, cast_sig, ptr)
					if ok_cast and cfn ~= nil then
						callable = cfn
					end
				end
				rawset(self, k, callable)
				return callable
			end
		end

		local gval = rawget(_G, k)
		if gval ~= nil then
			return gval
		end

		return nil
	end
}
setmetatable(bass, bass_mt)

BASS_OK = 0
BASS_ERROR_MEM = 1
BASS_ERROR_FILEOPEN = 2
BASS_ERROR_DRIVER = 3
BASS_ERROR_BUFLOST = 4
BASS_ERROR_HANDLE = 5
BASS_ERROR_FORMAT = 6
BASS_ERROR_POSITION = 7
BASS_ERROR_INIT = 8
BASS_ERROR_START = 9
BASS_ERROR_SSL = 10
BASS_ERROR_ALREADY = 14
BASS_ERROR_NOCHAN = 18
BASS_ERROR_ILLTYPE = 19
BASS_ERROR_ILLPARAM = 20
BASS_ERROR_NO3D = 21
BASS_ERROR_NOEAX = 22
BASS_ERROR_DEVICE = 23
BASS_ERROR_NOPLAY = 24
BASS_ERROR_FREQ = 25
BASS_ERROR_NOTFILE = 27
BASS_ERROR_NOHW = 29
BASS_ERROR_EMPTY = 31
BASS_ERROR_NONET = 32
BASS_ERROR_CREATE = 33
BASS_ERROR_NOFX = 34
BASS_ERROR_NOTAVAIL = 37
BASS_ERROR_DECODE = 38
BASS_ERROR_DX = 39
BASS_ERROR_TIMEOUT = 40
BASS_ERROR_FILEFORM = 41
BASS_ERROR_SPEAKER = 42
BASS_ERROR_VERSION = 43
BASS_ERROR_CODEC = 44
BASS_ERROR_ENDED = 45
BASS_ERROR_BUSY = 46
BASS_ERROR_UNKNOWN = -1
BASS_CONFIG_BUFFER = 0
BASS_CONFIG_UPDATEPERIOD = 1
BASS_CONFIG_GVOL_SAMPLE = 4
BASS_CONFIG_GVOL_STREAM = 5
BASS_CONFIG_GVOL_MUSIC = 6
BASS_CONFIG_CURVE_VOL = 7
BASS_CONFIG_CURVE_PAN = 8
BASS_CONFIG_FLOATDSP = 9
BASS_CONFIG_3DALGORITHM = 10
BASS_CONFIG_NET_TIMEOUT = 11
BASS_CONFIG_NET_BUFFER = 12
BASS_CONFIG_PAUSE_NOPLAY = 13
BASS_CONFIG_NET_PREBUF = 15
BASS_CONFIG_NET_PASSIVE = 18
BASS_CONFIG_REC_BUFFER = 19
BASS_CONFIG_NET_PLAYLIST = 21
BASS_CONFIG_MUSIC_VIRTUAL = 22
BASS_CONFIG_VERIFY = 23
BASS_CONFIG_UPDATETHREADS = 24
BASS_CONFIG_DEV_BUFFER = 27
BASS_CONFIG_VISTA_TRUEPOS = 30
BASS_CONFIG_IOS_MIXAUDIO = 34
BASS_CONFIG_DEV_DEFAULT = 36
BASS_CONFIG_NET_READTIMEOUT = 37
BASS_CONFIG_VISTA_SPEAKERS = 38
BASS_CONFIG_IOS_SPEAKER = 39
BASS_CONFIG_MF_DISABLE = 40
BASS_CONFIG_HANDLES = 41
BASS_CONFIG_UNICODE = 42
BASS_CONFIG_SRC = 43
BASS_CONFIG_SRC_SAMPLE = 44
BASS_CONFIG_ASYNCFILE_BUFFER = 45
BASS_CONFIG_OGG_PRESCAN = 47
BASS_CONFIG_MF_VIDEO = 48
BASS_CONFIG_AIRPLAY = 49
BASS_CONFIG_DEV_NONSTOP = 50
BASS_CONFIG_IOS_NOCATEGORY = 51
BASS_CONFIG_VERIFY_NET = 52
BASS_CONFIG_NET_AGENT = 16
BASS_CONFIG_NET_PROXY = 17
BASS_CONFIG_IOS_NOTIFY = 46
BASS_DEVICE_8BITS = 1
BASS_DEVICE_MONO = 2
BASS_DEVICE_3D = 4
BASS_DEVICE_LATENCY = 0x100
BASS_DEVICE_CPSPEAKERS = 0x400
BASS_DEVICE_SPEAKERS = 0x800
BASS_DEVICE_NOSPEAKER = 0x1000
BASS_DEVICE_DMIX = 0x2000
BASS_DEVICE_FREQ = 0x4000
BASS_OBJECT_DS = 1
BASS_OBJECT_DS3DL = 2
BASS_DEVICE_ENABLED = 1
BASS_DEVICE_DEFAULT = 2
BASS_DEVICE_INIT = 4
BASS_DEVICE_TYPE_MASK = 0xff000000
BASS_DEVICE_TYPE_NETWORK = 0x01000000
BASS_DEVICE_TYPE_SPEAKERS = 0x02000000
BASS_DEVICE_TYPE_LINE = 0x03000000
BASS_DEVICE_TYPE_HEADPHONES = 0x04000000
BASS_DEVICE_TYPE_MICROPHONE = 0x05000000
BASS_DEVICE_TYPE_HEADSET = 0x06000000
BASS_DEVICE_TYPE_HANDSET = 0x07000000
BASS_DEVICE_TYPE_DIGITAL = 0x08000000
BASS_DEVICE_TYPE_SPDIF = 0x09000000
BASS_DEVICE_TYPE_HDMI = 0x0a000000
BASS_DEVICE_TYPE_DISPLAYPORT = 0x40000000
BASS_DEVICES_AIRPLAY = 0x1000000
DSCAPS_CONTINUOUSRATE = 0x00000010
DSCAPS_EMULDRIVER = 0x00000020
DSCAPS_CERTIFIED = 0x00000040
DSCAPS_SECONDARYMONO = 0x00000100
DSCAPS_SECONDARYSTEREO = 0x00000200
DSCAPS_SECONDARY8BIT = 0x00000400
DSCAPS_SECONDARY16BIT = 0x00000800
DSCCAPS_EMULDRIVER = DSCAPS_EMULDRIVER
DSCCAPS_CERTIFIED = DSCAPS_CERTIFIED
WAVE_FORMAT_1M08 = 0x00000001
WAVE_FORMAT_1S08 = 0x00000002
WAVE_FORMAT_1M16 = 0x00000004
WAVE_FORMAT_1S16 = 0x00000008
WAVE_FORMAT_2M08 = 0x00000010
WAVE_FORMAT_2S08 = 0x00000020
WAVE_FORMAT_2M16 = 0x00000040
WAVE_FORMAT_2S16 = 0x00000080
WAVE_FORMAT_4M08 = 0x00000100
WAVE_FORMAT_4S08 = 0x00000200
WAVE_FORMAT_4M16 = 0x00000400
WAVE_FORMAT_4S16 = 0x00000800
BASS_SAMPLE_8BITS = 1
BASS_SAMPLE_FLOAT = 256
BASS_SAMPLE_MONO = 2
BASS_SAMPLE_LOOP = 4
BASS_SAMPLE_3D = 8
BASS_SAMPLE_SOFTWARE = 16
BASS_SAMPLE_MUTEMAX = 32
BASS_SAMPLE_VAM = 64
BASS_SAMPLE_FX = 128
BASS_SAMPLE_OVER_VOL = 0x10000
BASS_SAMPLE_OVER_POS = 0x20000
BASS_SAMPLE_OVER_DIST = 0x30000
BASS_STREAM_PRESCAN = 0x20000
BASS_MP3_SETPOS = BASS_STREAM_PRESCAN
BASS_STREAM_AUTOFREE = 0x40000
BASS_STREAM_RESTRATE = 0x80000
BASS_STREAM_BLOCK = 0x100000
BASS_STREAM_DECODE = 0x200000
BASS_STREAM_STATUS = 0x800000
BASS_MIXER_END = 0x10000
BASS_MUSIC_FLOAT = BASS_SAMPLE_FLOAT
BASS_MUSIC_MONO = BASS_SAMPLE_MONO
BASS_MUSIC_LOOP = BASS_SAMPLE_LOOP
BASS_MUSIC_3D = BASS_SAMPLE_3D
BASS_MUSIC_FX = BASS_SAMPLE_FX
BASS_MUSIC_AUTOFREE = BASS_STREAM_AUTOFREE
BASS_MUSIC_DECODE = BASS_STREAM_DECODE
BASS_MUSIC_PRESCAN = BASS_STREAM_PRESCAN
BASS_MUSIC_CALCLEN = BASS_MUSIC_PRESCAN
BASS_MUSIC_RAMP = 0x200
BASS_MUSIC_RAMPS = 0x400
BASS_MUSIC_SURROUND = 0x800
BASS_MUSIC_SURROUND2 = 0x1000
BASS_MUSIC_FT2MOD = 0x2000
BASS_MUSIC_PT1MOD = 0x4000
BASS_MUSIC_NONINTER = 0x10000
BASS_MUSIC_SINCINTER = 0x800000
BASS_MUSIC_POSRESET = 0x8000
BASS_MUSIC_POSRESETEX = 0x400000
BASS_MUSIC_STOPBACK = 0x80000
BASS_MUSIC_NOSAMPLE = 0x100000
BASS_SPEAKER_FRONT = 0x1000000
BASS_SPEAKER_REAR = 0x2000000
BASS_SPEAKER_CENLFE = 0x3000000
BASS_SPEAKER_REAR2 = 0x4000000

BASS_SPEAKER_LEFT = 0x10000000
BASS_SPEAKER_RIGHT = 0x20000000
BASS_SPEAKER_FRONTLEFT = bit.bor(BASS_SPEAKER_FRONT, BASS_SPEAKER_LEFT)
BASS_SPEAKER_FRONTRIGHT = bit.bor(BASS_SPEAKER_FRONT, BASS_SPEAKER_RIGHT)
BASS_SPEAKER_REARLEFT = bit.bor(BASS_SPEAKER_REAR, BASS_SPEAKER_LEFT)
BASS_SPEAKER_REARRIGHT = bit.bor(BASS_SPEAKER_REAR, BASS_SPEAKER_RIGHT)
BASS_SPEAKER_CENTER = bit.bor(BASS_SPEAKER_CENLFE, BASS_SPEAKER_LEFT)
BASS_SPEAKER_LFE = bit.bor(BASS_SPEAKER_CENLFE, BASS_SPEAKER_RIGHT)
BASS_SPEAKER_REAR2LEFT = bit.bor(BASS_SPEAKER_REAR2, BASS_SPEAKER_LEFT)
BASS_SPEAKER_REAR2RIGHT = bit.bor(BASS_SPEAKER_REAR2, BASS_SPEAKER_RIGHT)
BASS_ASYNCFILE = 0x40000000
BASS_UNICODE = 0x80000000
BASS_RECORD_PAUSE = 0x8000
BASS_RECORD_ECHOCANCEL = 0x2000
BASS_RECORD_AGC = 0x4000
BASS_VAM_HARDWARE = 1
BASS_VAM_SOFTWARE = 2
BASS_VAM_TERM_TIME = 4
BASS_VAM_TERM_DIST = 8
BASS_VAM_TERM_PRIO = 16
BASS_CTYPE_SAMPLE = 1
BASS_CTYPE_RECORD = 2
BASS_CTYPE_STREAM = 0x10000
BASS_CTYPE_STREAM_OGG = 0x10002
BASS_CTYPE_STREAM_MP1 = 0x10003
BASS_CTYPE_STREAM_MP2 = 0x10004
BASS_CTYPE_STREAM_MP3 = 0x10005
BASS_CTYPE_STREAM_AIFF = 0x10006
BASS_CTYPE_STREAM_CA = 0x10007
BASS_CTYPE_STREAM_MF = 0x10008
BASS_CTYPE_STREAM_WAV = 0x40000
BASS_CTYPE_STREAM_WAV_PCM = 0x50001
BASS_CTYPE_STREAM_WAV_FLOAT = 0x50003
BASS_CTYPE_MUSIC_MOD = 0x20000
BASS_CTYPE_MUSIC_MTM = 0x20001
BASS_CTYPE_MUSIC_S3M = 0x20002
BASS_CTYPE_MUSIC_XM = 0x20003
BASS_CTYPE_MUSIC_IT = 0x20004
BASS_CTYPE_MUSIC_MO3 = 0x00100
BASS_3DMODE_NORMAL = 0
BASS_3DMODE_RELATIVE = 1
BASS_3DMODE_OFF = 2
BASS_3DALG_DEFAULT = 0
BASS_3DALG_OFF = 1
BASS_3DALG_FULL = 2
BASS_3DALG_LIGHT = 3

BASS_STREAMPROC_END = 0x80000000

STREAMFILE_NOBUFFER = 0
STREAMFILE_BUFFER = 1
STREAMFILE_BUFFERPUSH = 2
BASS_FILEDATA_END = 0
BASS_FILEPOS_CURRENT = 0
BASS_FILEPOS_DECODE = BASS_FILEPOS_CURRENT
BASS_FILEPOS_DOWNLOAD = 1
BASS_FILEPOS_END = 2
BASS_FILEPOS_START = 3
BASS_FILEPOS_CONNECTED = 4
BASS_FILEPOS_BUFFER = 5
BASS_FILEPOS_SOCKET = 6
BASS_FILEPOS_ASYNCBUF = 7
BASS_FILEPOS_SIZE = 8
BASS_SYNC_POS = 0
BASS_SYNC_END = 2
BASS_SYNC_META = 4
BASS_SYNC_SLIDE = 5
BASS_SYNC_STALL = 6
BASS_SYNC_DOWNLOAD = 7
BASS_SYNC_FREE = 8
BASS_SYNC_SETPOS = 11
BASS_SYNC_MUSICPOS = 10
BASS_SYNC_MUSICINST = 1
BASS_SYNC_MUSICFX = 3
BASS_SYNC_OGG_CHANGE = 12
BASS_SYNC_MIXTIME = 0x40000000
BASS_SYNC_ONETIME = 0x80000000
BASS_ACTIVE_STOPPED = 0
BASS_ACTIVE_PLAYING = 1
BASS_ACTIVE_STALLED = 2
BASS_ACTIVE_PAUSED = 3
BASS_ATTRIB_FREQ = 1
BASS_ATTRIB_VOL = 2
BASS_ATTRIB_PAN = 3
BASS_ATTRIB_EAXMIX = 4
BASS_ATTRIB_NOBUFFER = 5
BASS_ATTRIB_VBR = 6
BASS_ATTRIB_CPU = 7
BASS_ATTRIB_SRC = 8
BASS_ATTRIB_NET_RESUME = 9
BASS_ATTRIB_SCANINFO = 10
BASS_ATTRIB_MUSIC_AMPLIFY = 0x100
BASS_ATTRIB_MUSIC_PANSEP = 0x101
BASS_ATTRIB_MUSIC_PSCALER = 0x102
BASS_ATTRIB_MUSIC_BPM = 0x103
BASS_ATTRIB_MUSIC_SPEED = 0x104
BASS_ATTRIB_MUSIC_VOL_GLOBAL = 0x105
BASS_ATTRIB_MUSIC_ACTIVE = 0x106
BASS_ATTRIB_MUSIC_VOL_CHAN = 0x200
BASS_ATTRIB_MUSIC_VOL_INST = 0x300
BASS_DATA_AVAILABLE = 0
BASS_DATA_FIXED = 0x20000000
BASS_DATA_FLOAT = 0x40000000
BASS_DATA_FFT256 = 0x80000000
BASS_DATA_FFT512 = 0x80000001
BASS_DATA_FFT1024 = 0x80000002
BASS_DATA_FFT2048 = 0x80000003
BASS_DATA_FFT4096 = 0x80000004
BASS_DATA_FFT8192 = 0x80000005
BASS_DATA_FFT16384 = 0x80000006
BASS_DATA_FFT_INDIVIDUAL = 0x10
BASS_DATA_FFT_NOWINDOW = 0x20
BASS_DATA_FFT_REMOVEDC = 0x40
BASS_DATA_FFT_COMPLEX = 0x80
BASS_LEVEL_MONO = 1
BASS_LEVEL_STEREO = 2
BASS_LEVEL_RMS = 4
BASS_TAG_ID3 = 0
BASS_TAG_ID3V2 = 1
BASS_TAG_OGG = 2
BASS_TAG_HTTP = 3
BASS_TAG_ICY = 4
BASS_TAG_META = 5
BASS_TAG_APE = 6
BASS_TAG_MP4 =  7
BASS_TAG_VENDOR = 9
BASS_TAG_LYRICS3 = 10
BASS_TAG_CA_CODEC = 11
BASS_TAG_MF = 13
BASS_TAG_WAVEFORMAT = 14
BASS_TAG_RIFF_INFO = 0x100
BASS_TAG_RIFF_BEXT = 0x101
BASS_TAG_RIFF_CART = 0x102
BASS_TAG_RIFF_DISP = 0x103
BASS_TAG_APE_BINARY = 0x1000
BASS_TAG_MUSIC_NAME = 0x10000
BASS_TAG_MUSIC_MESSAGE = 0x10001
BASS_TAG_MUSIC_ORDERS = 0x10002
BASS_TAG_MUSIC_INST = 0x10100
BASS_TAG_MUSIC_SAMPLE = 0x10300
BASS_POS_BYTE = 0
BASS_POS_MUSIC_ORDER = 1
BASS_POS_OGG = 3
BASS_POS_INEXACT = 0x8000000
BASS_POS_DECODE = 0x10000000
BASS_POS_DECODETO = 0x20000000
BASS_POS_SCAN = 0x40000000
BASS_INPUT_OFF = 0x10000
BASS_INPUT_ON = 0x20000
BASS_INPUT_TYPE_MASK = 0xff000000
BASS_INPUT_TYPE_UNDEF = 0x00000000
BASS_INPUT_TYPE_DIGITAL = 0x01000000
BASS_INPUT_TYPE_LINE = 0x02000000
BASS_INPUT_TYPE_MIC = 0x03000000
BASS_INPUT_TYPE_SYNTH = 0x04000000
BASS_INPUT_TYPE_CD = 0x05000000
BASS_INPUT_TYPE_PHONE = 0x06000000
BASS_INPUT_TYPE_SPEAKER = 0x07000000
BASS_INPUT_TYPE_WAVE = 0x08000000
BASS_INPUT_TYPE_AUX = 0x09000000
BASS_INPUT_TYPE_ANALOG = 0x0a000000
BASS_IOSNOTIFY_INTERRUPT = 1
BASS_IOSNOTIFY_INTERRUPT_END = 2

return bass
