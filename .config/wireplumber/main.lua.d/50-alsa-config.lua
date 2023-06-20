alsa_monitor.enabled = true

alsa_monitor.properties = {
  -- Create a JACK device. This is not enabled by default because
  -- it requires that the PipeWire JACK replacement libraries are
  -- not used by the session manager, in order to be able to
  -- connect to the real JACK server.
  --["alsa.jack-device"] = false,

  -- Reserve devices via org.freedesktop.ReserveDevice1 on D-Bus
  -- Disable if you are running a system-wide instance, which
  -- doesn't have access to the D-Bus user session
  ["alsa.reserve"] = true,
  --["alsa.reserve.priority"] = -20,
  --["alsa.reserve.application-name"] = "WirePlumber",

  -- Enables MIDI functionality
  ["alsa.midi"] = true,

  -- Enables monitoring of alsa MIDI devices
  ["alsa.midi.monitoring"] = true,

  -- MIDI bridge node properties
  ["alsa.midi.node-properties"] = {
    -- Name set for the node with ALSA MIDI ports
    ["node.name"] = "Midi-Bridge",
    -- Removes longname/number from MIDI port names
    --["api.alsa.disable-longname"] = true,
  },

  -- These properties override node defaults when running in a virtual machine.
  -- The rules below still override those.
  ["vm.node.defaults"] = {
    ["api.alsa.period-size"] = 256,
    ["api.alsa.headroom"] = 8192,
  },
}

alsa_monitor.rules = {
  -- An array of matches/actions to evaluate.
  --
  -- If you want to disable some devices or nodes, you can apply properties per device as the following example.
  -- The name can be found by running pw-cli ls Device, or pw-cli dump Device
  --{
  --  matches = {
  --    {
  --      { "device.name", "matches", "name_of_some_disabled_card" },
  --    },
  --  },
  --  apply_properties = {
  --    ["device.disabled"] = true,
  --  },
  --}
  {
    -- Rules for matching a device or node. It is an array of
    -- properties that all need to match the regexp. If any of the
    -- matches work, the actions are executed for the object.
    matches = {
      {
        -- This matches all cards.
        { "device.name", "matches", "alsa_card.*" },
      },
    },
    -- Apply properties on the matched object.
    apply_properties = {
      -- Use ALSA-Card-Profile devices. They use UCM or the profile
      -- configuration to configure the device and mixer settings.
      ["api.alsa.use-acp"] = true,

      -- Use UCM instead of profile when available. Can be
      -- disabled to skip trying to use the UCM profile.
      --["api.alsa.use-ucm"] = true,

      -- Don't use the hardware mixer for volume control. It
      -- will only use software volume. The mixer is still used
      -- to mute unused paths based on the selected port.
      --["api.alsa.soft-mixer"] = false,

      -- Ignore decibel settings of the driver. Can be used to
      -- work around buggy drivers that report wrong values.
      --["api.alsa.ignore-dB"] = false,

      -- The profile set to use for the device. Usually this is
      -- "default.conf" but can be changed with a udev rule or here.
      --["device.profile-set"] = "profileset-name",

      -- The default active profile. Is by default set to "Off".
      --["device.profile"] = "default profile name",

      -- Automatically select the best profile. This is the
      -- highest priority available profile. This is disabled
      -- here and instead implemented in the session manager
      -- where it can save and load previous preferences.
      ["api.acp.auto-profile"] = false,

      -- Automatically switch to the highest priority available port.
      -- This is disabled here and implemented in the session manager instead.
      ["api.acp.auto-port"] = false,

      -- Other properties can be set here.
      --["device.nick"] = "My Device",
    },
  },
  {
    matches = {
      {
        -- Matches all sources.
        { "node.name", "matches", "alsa_input.*" },
      },
      {
        -- Matches all sinks.
        { "node.name", "matches", "alsa_output.*" },
      },
    },
    apply_properties = {
      --["node.nick"]              = "My Node",
      --["node.description"]       = "My Node Description",
      --["priority.driver"]        = 100,
      --["priority.session"]       = 100,
      --["node.pause-on-idle"]     = false,
      --["monitor.channel-volumes"] = false
      -- Use highest resampling quality possible
      ["resample.quality"]         = 15,
      --["resample.disable"]       = false,
      -- Ensure things don't go awry with processing
      ["channelmix.normalize"]     = true,
      --["channelmix.mix-lfe"]     = false,
      --["channelmix.upmix"]       = true,
      --["channelmix.upmix-method"] = "psd",  -- "none" or "simple"
      --["channelmix.lfe-cutoff"]  = 150,
      --["channelmix.fc-cutoff"]   = 12000,
      --["channelmix.rear-delay"]  = 12.0,
      --["channelmix.stereo-widen"] = 0.0,
      --["channelmix.hilbert-taps"] = 0,
      --["channelmix.disable"]     = false,
      --["dither.noise"]           = 0,
      --["dither.method"]          = "none",  -- "rectangular", "triangular" or "shaped5"
      --["audio.channels"]         = 2,
      --["audio.format"]           = "S16LE",
      --["audio.rate"]             = 44100,
      --["audio.allowed-rates"]    = "32000,96000",
      --["audio.position"]         = "FL,FR",
      --["api.alsa.period-size"]   = 1024,
      --["api.alsa.period-num"]    = 2,
      --["api.alsa.headroom"]      = 0,
      --["api.alsa.start-delay"]   = 0,
      --["api.alsa.disable-mmap"]  = false,
      --["api.alsa.disable-batch"] = false,
      --["api.alsa.use-chmap"]     = false,
      --["api.alsa.multirate"]     = true,
      --["latency.internal.rate"]  = 0
      --["latency.internal.ns"]    = 0
      --["clock.name"]             = "api.alsa.0"
      --["session.suspend-timeout-seconds"] = 5,  -- 0 disables suspend
    },
  },
  -- Begin rule changes for built-in audio devices
  {
    matches = {
      {
        -- Common profile to be applied to the Realtek ALC897 audio device
        { "node.name", "matches", "*.pci-0000_00_1f.3.*" },
        { "alsa.id", "matches", "ALC897 *" },
      },
    },
    apply_properties = {
      -- Always open device with 24-bit stereo @ 192 kHz profile
      ["audio.channels"] = 2,
      ["audio.format"] = "S24_3LE",
      ["audio.rate"] = 192000,
      -- PCM interrupt will be generated every ~100 ms for target profile above.
      -- See https://www.alsa-project.org/main/index.php/FramesPeriods for details
      ["api.alsa.period-size"] = 38400,
    },
  },
  {
    matches = {
      {
        -- Profile applies correct supported sampling rates for the analog ports
        { "node.name", "matches", "*.pci-0000_00_1f.3.analog-*" },
        { "alsa.id", "matches", "ALC897 Analog" },
      },
    },
    apply_properties = {
      -- Supported sample rates as obtained from procfs
      -- 32 kHz and 88.2 kHz are unsupported for analog ports
      ["audio.allowed-rates"] = "44100,48000,96000,192000",
    },
  },
  {
    matches = {
      {
        -- Profile applies correct supported sampling rates for the S/PDIF output
        { "node.name", "matches", "alsa_output.pci-0000_00_1f.3.iec958-stereo" },
        { "alsa.id", "matches", "ALC897 Digital" },
      },
    },
    apply_properties = {
      -- Supported sample rates as obtained from procfs
      -- 32 kHz and 88.2 kHz are additionally supported for S/PDIF output
      ["audio.allowed-rates"] = "32000,44100,48000,88200,96000,192000",
    },
  },
  {
    matches = {
      {
        -- Match both input and output of the Conexant CX20751/2 audio device
        { "node.name", "matches", "*.pci-0000_00_1f.3.*" },
        { "alsa.id", "matches", "CX20751/2 Analog" },
      },
    },
    apply_properties = {
      -- Always open device with 24-bit stereo @ 48 kHz profile
      ["audio.channels"] = 2,
      ["audio.format"] = "S24_3LE",
      ["audio.rate"] = 48000,
      -- Supported sample rates as obtained from procfs
      ["audio.allowed-rates"] = "44100,48000",
      -- PCM interrupt will be generated every ~100 ms for target profile above.
      -- See https://www.alsa-project.org/main/index.php/FramesPeriods for details
      ["api.alsa.period-size"] = 9600,
    },
  },
  -- End rule changes for built-in audio devices
  -- Begin rule changes for USB DAC
  {
    matches = {
      {
        -- Match exactly this device name
        { "device.name", "matches", "alsa_card.usb-Synaptics_CX31993_HIFI_AUDIO-00" },
      },
    },
    apply_properties = {
      -- Use a more friendly approach to naming conventions
      ["device.nick"] = "JCally JM6 - CX31993 USB DAC",
    },
  },
  {
    matches = {
      {
        -- This matches any of both input and output (sink) devices
        { "node.name", "matches", "*.usb-Synaptics_CX31993_HIFI_AUDIO-00.*" },
      },
    },
    apply_properties = {
      -- Use a more friendly approach to naming conventions
      ["node.nick"] = "JCally JM6 - CX31993 USB DAC",
    },
  },
  {
    matches = {
      {
        -- This can be either analog or digital output, or Pro Audio
        { "node.name", "matches", "alsa_output.usb-Synaptics_CX31993_HIFI_AUDIO-00.*" },
      },
    },
    apply_properties = {
      -- Always open device with 32-bit stereo @ 192 kHz profile
      ["audio.channels"] = 2,
      ["audio.format"] = "S32_LE",
      ["audio.rate"] = 192000,
      -- Supported sample rates as obtained from procfs
      ["audio.allowed-rates"] = "8000,16000,32000,44100,48000,96000,192000,384000",
      -- PCM interrupt will be generated every ~80 ms for target profile above.
      -- See https://www.alsa-project.org/main/index.php/FramesPeriods for details
      ["api.alsa.period-size"] = 15360,
      -- Disable batch tweaks for devices that might perform better without it
      ["api.alsa.disable-batch"] = true,
    },
  },
  {
    matches = {
      {
        -- Profile for the Edifier G2000 USB DAC output (matches both analog and digital)
        { "node.name", "matches", "alsa_output.usb-EDIFIER_EDIFIER_G2000_EDI00000X07-01.*" },
      },
    },
    apply_properties = {
      -- Not much can be done here due to limited capabilities
      -- Headroom / period size is determined by WirePlumber on batched USB DAC devices
      ["audio.channels"] = 2,
      ["audio.format"] = "S16_LE",
      ["audio.rate"] = 48000,
      ["audio.allowed-rates"] = "48000",
    },
  },
  -- End rule changes for USB DAC
}
