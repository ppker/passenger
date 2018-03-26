#  Phusion Passenger - https://www.phusionpassenger.com/
#  Copyright (c) 2014-2017 Phusion Holding B.V.
#
#  "Passenger", "Phusion Passenger" and "Union Station" are registered
#  trademarks of Phusion Holding B.V.
#
#  Permission is hereby granted, free of charge, to any person obtaining a copy
#  of this software and associated documentation files (the "Software"), to deal
#  in the Software without restriction, including without limitation the rights
#  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#  copies of the Software, and to permit persons to whom the Software is
#  furnished to do so, subject to the following conditions:
#
#  The above copyright notice and this permission notice shall be included in
#  all copies or substantial portions of the Software.
#
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
#  THE SOFTWARE.

# This file defines all supported Apache per-directory configuration options. The
# build system automatically generates the corresponding Apache module boilerplate
# code from the definitions in this file.
#
# Main configuration options are not defined in this file, but are defined in
# src/apache2_module/Configuration.cpp instead.
#
# The following boilerplate code is generated:
#
#  * command_rec array members (ConfigGeneral/AutoGeneratedDefinitions.cpp.cxxcodebuilder)
#  * Global (server-wide) struct fields (ServerConfig/AutoGeneratedStruct.cpp.cxxcodebuilder)
#  * Per-directory struct (DirConfig/AutoGeneratedStruct.h.cxxcodebuilder)
#  * Per-directory struct fields initialization code (DirConfig/AutoGeneratedCreateFunction.cpp.cxxcodebuilder)
#  * Per-directory struct fields merging code (DirConfig/AutoGeneratedMergeFunction.cpp.cxxcodebuilder)
#  * Struct field setter functions (ConfigGeneral/AutoGeneratedSetterFuncs.cpp.cxxcodebuilder)
#  * Apache module <-> Core headers serialization code (ConfigGeneral/AutoGeneratedHeaderSerialization.cpp.cxxcodebuilder)
#
# Options:
#
#  * name - The configuration option name. Required.
#  * context - The context in which this configuration option is valid.
#              Allowed values:
#              :global -- Global configuration
#              :application -- Per-application configuration (default)
#              :location -- Per-location/per-request configuration
#  * htaccess_context - If `context` is set to :location, then this
#              defines whether -- and in which -- .htaccess contexts it is allowed.
#              This is an array of `OR_` macro names.
#              Default: ['OR_OPTIONS']
#  * type - This configuration option's value type. Allowed types:
#           :string, :integer, :flag, :string_array, :string_keyval, :string_set
#  * field - The name that should be used for the auto-generated field in
#            the configuration structure. Defaults to the configuration
#            name without the 'Passenger' prefix, and in camel case. Set this
#            to nil if you do not want a structure field to be auto-generated.
#  * min_value - If `type` is :integer, then this specifies the minimum
#                allowed value. When nil (the default), there is no minimum.
#  * default - A static default value. Set during configuration merging,
#              and reported in the tracking code that generates the
#              configuration manifest.
#  * default_expr - If `default` is set, but you don't want the value
#                   to appear in the autogenerated code (e.g. you want the
#                   autogenerated code to contain the corresponding constant name)
#                   when you can use this option to override what gets written in the
#                   autogenerated code.
#  * dynamic_default - If this option has a default, but it's dynamically inferred
#              (and not a static value) then set this option to a human-readable
#              description that explains how the default is dynamically inferred.
#              Reported in the tracking code that generates the configuration
#              manifest.
#  * desc - A description for this configuration option. Required.
#  * header - The name of the corresponding CGI header. By default CGI header
#             generation code is automatically generated, using the configuration
#             option's name in uppercase as the CGI header name.
#             Setting this to nil will disable auto-generation of CGI header
#             generation code. You are then responsible for writing CGI header
#             passing code yourself in Hooks.cpp.
#  * header_expression - The expression to be passed to `addHeader()`.
#  * function - If nil, a setter function will be automatically generated. If
#               non-nil, must be the name of the setter function.
#  * obsolete - Whether this is an obsolete option. Defaults to false.
#  * obsoletion_message - If the `obsolete` option is true, then
#               specify the obsoletion warning message here. This is optional:
#               there is a default obsoletion message.

PhusionPassenger.require_passenger_lib 'constants'
PhusionPassenger.require_passenger_lib 'apache2/config_utils'

APACHE2_CONFIGURATION_OPTIONS = [
  ###### Global configuration ######

  {
    :name      => 'PassengerRoot',
    :type      => :string,
    :context   => :global,
    :desc      => "The #{PROGRAM_NAME} root folder."
  },
  {
    :name      => 'PassengerCtl',
    :type      => :string_keyval,
    :context   => :global,
    :field     => nil,
    :function  => 'cmd_passenger_ctl',
    :desc      => "Set advanced #{PROGRAM_NAME} options."
  },
  {
    :name      => 'PassengerDumpConfigManifest',
    :type      => :string,
    :context   => :global,
    :desc      => "Dump the #{SHORT_PROGRAM_NAME} config manifest to the given file, for debugging purposes."
  },
  {
    :name      => 'PassengerDefaultRuby',
    :type      => :string,
    :context   => :global,
    :default   => DEFAULT_RUBY,
    :default_expr => 'DEFAULT_RUBY',
    :desc      => "#{PROGRAM_NAME}'s default Ruby interpreter to use."
  },
  {
    :name      => 'PassengerLogLevel',
    :type      => :integer,
    :context   => :global,
    :min_value => 0,
    :default   => DEFAULT_LOG_LEVEL,
    :default_expr => 'DEFAULT_LOG_LEVEL',
    :desc      => "The #{PROGRAM_NAME} log verbosity."
  },
  {
    :name      => 'PassengerLogFile',
    :type      => :string,
    :context   => :global,
    :dynamic_default => "Apache's global error log",
    :desc      => "The #{PROGRAM_NAME} log file."
  },
  {
    :name      => 'PassengerSocketBacklog',
    :type      => :integer,
    :context   => :global,
    :min_value => 0,
    :default   => DEFAULT_SOCKET_BACKLOG,
    :default_expr => 'DEFAULT_SOCKET_BACKLOG',
    :desc      => "The #{PROGRAM_NAME} socket backlog."
  },
  {
    :name      => 'PassengerFileDescriptorLogFile',
    :type      => :string,
    :context   => :global,
    :desc      => "The #{PROGRAM_NAME} file descriptor log file."
  },
  {
    :name      => 'PassengerMaxPoolSize',
    :type      => :integer,
    :context   => :global,
    :min_value => 1,
    :default   => DEFAULT_MAX_POOL_SIZE,
    :default_expr => 'DEFAULT_MAX_POOL_SIZE',
    :desc      => "The maximum number of simultaneously alive application processes."
  },
  {
    :name      => 'PassengerPoolIdleTime',
    :type      => :integer,
    :context   => :global,
    :min_value => 0,
    :default   => DEFAULT_POOL_IDLE_TIME,
    :default_expr => 'DEFAULT_POOL_IDLE_TIME',
    :desc      => 'The maximum number of seconds that an application may be idle before it gets terminated.'
  },
  {
    :name      => 'PassengerResponseBufferHighWatermark',
    :type      => :integer,
    :context   => :global,
    :min_value => 0,
    :default   => DEFAULT_RESPONSE_BUFFER_HIGH_WATERMARK,
    :default_expr => 'DEFAULT_RESPONSE_BUFFER_HIGH_WATERMARK',
    :desc      => "The maximum size of the #{PROGRAM_NAME} response buffer."
  },
  {
    :name      => 'PassengerUserSwitching',
    :type      => :flag,
    :context   => :global,
    :default   => true,
    :desc      => "Whether to enable user switching support in #{PROGRAM_NAME}."
  },
  {
    :name      => 'PassengerDefaultUser',
    :type      => :string,
    :context   => :global,
    :default   => PASSENGER_DEFAULT_USER,
    :default_expr => 'PASSENGER_DEFAULT_USER',
    :desc      => "The user that #{PROGRAM_NAME} applications must run as when user switching fails or is disabled."
  },
  {
    :name      => 'PassengerDefaultGroup',
    :type      => :string,
    :context   => :global,
    :dynamic_default => 'The primary group of PassengerDefaultUser',
    :desc      => "The group that #{PROGRAM_NAME} applications must run as when user switching fails or is disabled."
  },
  {
    :name      => 'PassengerDataBufferDir',
    :type      => :string,
    :context   => :global,
    :dynamic_default => '$TMPDIR, or if not given, /tmp',
    :desc      => "The directory that #{PROGRAM_NAME} data buffers should be stored into."
  },
  {
    :name      => 'PassengerInstanceRegistryDir',
    :type      => :string,
    :context   => :global,
    :dynamic_default => 'Either /var/run/passenger-instreg, $TMPDIR, or /tmp (see docs)',
    :desc      => "The directory to register the #{PROGRAM_NAME} instance to."
  },
  {
    :name      => 'PassengerDisableSecurityUpdateCheck',
    :type      => :flag,
    :context   => :global,
    :default   => false,
    :desc      => "Whether to disable the #{PROGRAM_NAME} security update check & notification."
  },
  {
    :name      => 'PassengerSecurityUpdateCheckProxy',
    :type      => :string,
    :context   => :global,
    :desc      => "Use specified HTTP/SOCKS proxy for the #{PROGRAM_NAME} security update check."
  },
  {
    :name      => 'PassengerStatThrottleRate',
    :type      => :integer,
    :context   => :global,
    :default   => DEFAULT_STAT_THROTTLE_RATE,
    :default_expr => 'DEFAULT_STAT_THROTTLE_RATE',
    :desc      => 'Limit the number of stat calls to once per given seconds.'
  },
  {
    :name      => 'PassengerPreStart',
    :type      => :string_set,
    :context   => :global,
    :field     => 'prestartURLs',
    :desc      => 'Prestart the given web applications during startup.'
  },
  {
    :name      => 'PassengerTurbocaching',
    :type      => :flag,
    :context   => :global,
    :default   => true,
    :desc      => "Whether to enable turbocaching in #{PROGRAM_NAME}."
  },
  {
    :name      => 'PassengerShowVersionInHeader',
    :type      => :flag,
    :context   => :global,
    :default   => true,
    :desc      => "Whether to show the #{PROGRAM_NAME} version number in the X-Powered-By header."
  },
  {
    :name      => 'PassengerMaxInstancesPerApp',
    :type      => :integer,
    :context   => :global,
    :min_value => 0,
    :default   => 0,
    :header    => 'PASSENGER_MAX_PROCESSES',
    :desc      => 'The maximum number of simultaneously alive application instances a single application may occupy.'
  },

  ###### Per-application configuration ######

  {
    :name      => 'PassengerRuby',
    :type      => :string,
    :default   => DEFAULT_RUBY,
    :default_expr => 'StaticString()',
    :desc      => 'The Ruby interpreter to use.',
    :header_expression => 'config->mRuby.empty() ? serverConfig.defaultRuby : config->mRuby'
  },
  {
    :name      => 'PassengerPython',
    :type      => :string,
    :default   => DEFAULT_PYTHON,
    :default_expr => 'DEFAULT_PYTHON',
    :desc      => 'The Python interpreter to use.'
  },
  {
    :name      => 'PassengerNodejs',
    :type      => :string,
    :default   => DEFAULT_NODEJS,
    :default_expr => 'DEFAULT_NODEJS',
    :desc      => 'The Node.js command to use.'
  },
  {
    :name      => 'PassengerMeteorAppSettings',
    :type      => :string,
    :desc      => 'Settings file for (non-bundled) Meteor apps.'
  },
  {
    :name      => 'PassengerBaseURI',
    :type      => :string_set,
    :function  => 'cmd_passenger_base_uri',
    :field     => 'mBaseURIs',
    :desc      => 'Declare the given base URI as belonging to a web application.',
    :header    => nil
  },
  {
    :name      => 'PassengerAppEnv',
    :type      => :string,
    :default   => 'production',
    :desc      => 'The environment under which applications are run.'
  },
  {
    :name      => 'PassengerAppType',
    :type      => :string,
    :dynamic_default => 'Autodetected',
    :desc      => 'Force specific application type.',
    :header    => nil
  },
  {
    :name      => 'PassengerStartupFile',
    :type      => :string,
    :dynamic_default => 'Autodetected',
    :desc      => 'Force specific startup file.'
  },
  {
    :name      => 'PassengerMinInstances',
    :type      => :integer,
    :min_value => 0,
    :default   => 1,
    :header    => 'PASSENGER_MIN_PROCESSES',
    :desc      => 'The minimum number of application instances to keep when cleaning idle instances.'
  },
  {
    :name      => 'PassengerUser',
    :type      => :string,
    :dynamic_default => 'See the user account sandboxing rules',
    :desc      => 'The user that Ruby applications must run as.'
  },
  {
    :name      => 'PassengerGroup',
    :type      => :string,
    :dynamic_default => 'See the user account sandboxing rules',
    :desc      => 'The group that Ruby applications must run as.'
  },
  {
    :name      => 'PassengerMaxRequests',
    :type      => :integer,
    :min_value => 0,
    :default   => 0,
    :desc      => 'The maximum number of requests that an application instance may process.'
  },
  {
    :name      => "PassengerStartTimeout",
    :type      => :integer,
    :min_value => 1,
    :default   => DEFAULT_START_TIMEOUT / 1000,
    :default_expr => 'DEFAULT_START_TIMEOUT / 1000',
    :desc      => 'A timeout for application startup.'
  },
  {
    :name      => 'PassengerMaxRequestQueueSize',
    :type      => :integer,
    :min_value => 0,
    :default   => DEFAULT_MAX_REQUEST_QUEUE_SIZE,
    :default_expr => 'DEFAULT_MAX_REQUEST_QUEUE_SIZE',
    :desc      => 'The maximum number of queued requests.'
  },
  {
    :name      => 'PassengerMaxPreloaderIdleTime',
    :type      => :integer,
    :min_value => 0,
    :default   => DEFAULT_MAX_PRELOADER_IDLE_TIME,
    :default_expr => 'DEFAULT_MAX_PRELOADER_IDLE_TIME',
    :desc      => 'The maximum number of seconds that a preloader process may be idle before it is shutdown.'
  },
  {
    :name      => 'PassengerLoadShellEnvvars',
    :type      => :flag,
    :default   => true,
    :desc      => 'Whether to load environment variables from the shell before running the application.'
  },
  {
    :name      => 'PassengerSpawnMethod',
    :type      => :string,
    :dynamic_default => "'smart' for Ruby apps, 'direct' for all other apps",
    :desc      => 'The spawn method to use.',
    :function  => 'cmd_passenger_spawn_method'
  },
  {
    :name      => 'PassengerFriendlyErrorPages',
    :type      => :flag,
    :dynamic_default => 'On if PassengerAppEnv is development, off otherwise',
    :desc      => 'Whether to display friendly error pages when something goes wrong.'
  },
  {
    :name      => 'PassengerRestartDir',
    :type      => :string,
    :default   => 'tmp',
    :desc      => "The directory in which #{PROGRAM_NAME} should look for restart.txt."
  },
  {
    :name      => 'PassengerAppGroupName',
    :type      => :string,
    :dynamic_default => 'PassengerAppRoot plus PassengerAppEnv',
    :desc      => 'Application process group name.'
  },
  {
    :name      => 'PassengerMonitorLogFile',
    :type      => :string_set,
    :header    => nil,
    :desc      => 'Log file path to monitor.'
  },
  {
    :name      => 'PassengerMonitorLogFile',
    :type      => :string_set,
    :header    => nil,
    :desc      => 'Log file path to monitor.'
  },
  {
    :name      => 'PassengerForceMaxConcurrentRequestsPerProcess',
    :type      => :integer,
    :default   => -1,
    :desc      => "Force #{SHORT_PROGRAM_NAME} to believe that an application process " \
                 "can handle the given number of concurrent requests per process"
  },
  {
    :name      => 'PassengerAppRoot',
    :type      => :string,
    :dynamic_default => "Parent directory of the associated Apache virtual host's root directory",
    :desc      => "The application's root directory.",
    :header    => nil
  },
  {
    :name      => 'PassengerLveMinUid',
    :type      => :integer,
    :min_value => 0,
    :default   => DEFAULT_LVE_MIN_UID,
    :default_expr => 'DEFAULT_LVE_MIN_UID',
    :desc      => 'Minimum user ID starting from which entering LVE and CageFS is allowed.'
  },


  ###### Per-location/per-request configuration ######

  {
    :name      => 'PassengerErrorOverride',
    :type      => :flag,
    :context   => :location,
    :htaccess_context => ['OR_ALL'],
    :default   => false,
    :desc      => 'Allow Apache to handle error response.',
    :header    => nil
  },
  {
    :name      => 'PassengerHighPerformance',
    :type      => :flag,
    :context   => :location,
    :htaccess_context => ['OR_ALL'],
    :default   => false,
    :desc      => "Enable or disable Passenger's high performance mode.",
    :header    => nil
  },
  {
    :name      => 'PassengerEnabled',
    :type      => :flag,
    :context   => :location,
    :htaccess_context => ['OR_ALL'],
    :default   => true,
    :desc      => "Enable or disable #{PROGRAM_NAME}.",
    :header    => nil
  },
  {
    :name      => 'PassengerBufferUpload',
    :type      => :flag,
    :context   => :location,
    :htaccess_context => ['OR_ALL'],
    :default   => true,
    :desc      => 'Whether to buffer file uploads.',
    :header    => nil
  },
  {
    :name      => 'PassengerStickySessions',
    :type      => :flag,
    :context   => :location,
    :htaccess_context => ['OR_ALL'],
    :default   => false,
    :desc      => 'Whether to enable sticky sessions.'
  },
  {
    :name      => 'PassengerStickySessionsCookieName',
    :type      => :string,
    :context   => :location,
    :htaccess_context => ['OR_ALL'],
    :default   => DEFAULT_STICKY_SESSIONS_COOKIE_NAME,
    :default_expr => 'DEFAULT_STICKY_SESSIONS_COOKIE_NAME',
    :desc      => 'The cookie name to use for sticky sessions.'
  },
  {
    :name      => 'PassengerBufferResponse',
    :type      => :flag,
    :context   => :location,
    :htaccess_context => ['OR_ALL'],
    :default   => false,
    :desc      => 'Whether to enable extra response buffering inside Apache.',
    :header    => nil
  },
  {
    :name      => 'PassengerAllowEncodedSlashes',
    :type      => :flag,
    :context   => :location,
    :default   => false,
    :desc      => "Whether to support encoded slashes in the URL",
    :header    => nil
  },


  ##### Enterprise options (placeholders in OSS) #####

  {
    :name      => 'PassengerFlyWith',
    :type      => :string,
    :context   => :global,
    :function  => 'cmd_passenger_enterprise_only',
    :field     => nil,
    :desc      => "Use Flying #{SHORT_PROGRAM_NAME}"
  },
  {
    :name      => 'PassengerMemoryLimit',
    :type      => :integer,
    :htaccess_context => ['OR_LIMIT'],
    :min_value => 0,
    :function  => 'cmd_passenger_enterprise_only',
    :field     => nil,
    :desc      => 'The maximum amount of memory in MB that an application instance may use.'
  },
  {
    :name      => 'PassengerMaxInstances',
    :type      => :integer,
    :htaccess_context => ['OR_LIMIT'],
    :min_value => 0,
    :function  => 'cmd_passenger_enterprise_only',
    :field     => nil,
    :desc      => "The maximum number of instances for the current application that #{PROGRAM_NAME} may spawn."
  },
  {
    :name      => 'PassengerRollingRestarts',
    :type      => :flag,
    :function  => 'cmd_passenger_enterprise_only',
    :field     => nil,
    :desc      => "Whether to turn on rolling restarts."
  },
  {
    :name      => 'PassengerResistDeploymentErrors',
    :type      => :flag,
    :function  => 'cmd_passenger_enterprise_only',
    :field     => nil,
    :desc      => 'Whether to turn on deployment error resistance.'
  },
  {
    :name      => 'PassengerDebugger',
    :type      => :flag,
    :function  => 'cmd_passenger_enterprise_only',
    :field     => nil,
    :desc      => 'Whether to turn on debugger support'
  },
  {
    :name      => 'PassengerConcurrencyModel',
    :type      => :string,
    :htaccess_context => ['OR_ALL'],
    :function  => 'cmd_passenger_enterprise_only',
    :field     => nil,
    :desc      => 'The concurrency model that should be used for applications.'
  },
  {
    :name      => 'PassengerThreadCount',
    :type      => :integer,
    :htaccess_context => ['OR_ALL'],
    :min_value => 0,
    :function  => 'cmd_passenger_enterprise_only',
    :field     => nil,
    :desc      => "The number of threads that #{PROGRAM_NAME} should spawn per application."
  },
  {
    :name      => 'PassengerMaxRequestTime',
    :type      => :integer,
    :context   => :location,
    :htaccess_context => ['OR_ALL'],
    :min_value => 0,
    :function  => 'cmd_passenger_enterprise_only',
    :field     => nil,
    :desc      => 'The maximum time (in seconds) that the current application may spend on a request.'
  },
  {
    :name      => 'PassengerMaxRequestQueueTime',
    :type      => :integer,
    :context   => :location,
    :htaccess_context => ['OR_ALL'],
    :min_value => 0,
    :function  => 'cmd_passenger_enterprise_only',
    :field     => nil,
    :desc      => 'The maximum number of seconds that a request may remain in the queue before it is dropped.'
  },


  ##### Aliases and backwards compatibility options #####

  {
    :name      => 'RailsEnv',
    :alias_for => 'PassengerAppEnv'
  },
  {
    :name      => 'RackEnv',
    :alias_for => 'PassengerAppEnv'
  },
  {
    :name      => 'RailsRuby',
    :alias_for => 'PassengerRuby'
  },
  {
    :name      => 'PassengerDebugLogFile',
    :alias_for => 'PassengerLogFile'
  },
  {
    :name      => 'RailsMaxPoolSize',
    :alias_for => 'PassengerMaxPoolSize'
  },
  {
    :name      => 'RailsMaxInstancesPerApp',
    :alias_for => 'PassengerMaxInstancesPerApp'
  },
  {
    :name      => 'RailsPoolIdleTime',
    :alias_for => 'PassengerPoolIdleTime'
  },
  {
    :name      => 'RailsUserSwitching',
    :alias_for => 'PassengerUserSwitching'
  },
  {
    :name      => 'RailsDefaultUser',
    :alias_for => 'PassengerDefaultUser'
  },
  {
    :name      => 'RailsAppSpawnerIdleTime',
    :alias_for => 'PassengerMaxPreloaderIdleTime'
  },
  {
    :name      => 'RailsBaseURI',
    :alias_for => 'PassengerBaseURI'
  },
  {
    :name      => 'RackBaseURI',
    :alias_for => 'PassengerBaseURI'
  },
  {
    :name      => 'RailsSpawnMethod',
    :alias_for => "PassengerSpawnMethod"
  },


  ##### Deprecated/obsolete options #####

  {
    :name      => 'RailsSpawnServer',
    :type      => :string,
    :context   => :global,
    :obsolete  => true,
    :obsoletion_message => "The 'RailsSpawnServer' option is obsolete. " \
      "Please specify 'PassengerRoot' instead. The correct value was " \
      "given to you by 'passenger-install-apache2-module'.",
    :desc      => 'Obsolete option.'
  },
  {
    :name      => "RailsAllowModRewrite",
    :type      => :flag,
    :context   => :global,
    :obsolete  => true,
    :obsoletion_message => "The 'RailsAllowModRewrite' option is obsolete: " \
      "#{PROGRAM_NAME} now fully supports mod_rewrite. " \
      "Please remove this option from your configuration file.",
    :desc      => 'Obsolete option.'
  },
  {
    :name      => "RailsFrameworkSpawnerIdleTime",
    :type      => :integer,
    :context   => :global,
    :obsolete  => true,
    :obsoletion_message => "The 'RailsFrameworkSpawnerIdleTime' option is obsolete. " \
      "Please use 'PassengerMaxPreloaderIdleTime' instead.",
    :desc      => 'Obsolete option.'
  },
  {
    :name      => 'PassengerUseGlobalQueue',
    :type      => :flag,
    :obsolete  => true,
    :obsoletion_message => "The 'PassengerUseGlobalQueue' option is obsolete: " \
      'global queueing is now always turned on. ' \
      'Please remove this option from your configuration file.',
    :desc      => 'Obsolete option.'
  },
  {
    :name      => 'UnionStationGatewayAddress',
    :type      => :string,
    :context   => :global,
    :obsolete  => true,
    :desc      => 'Obsolete option.'
  },
  {
    :name      => 'UnionStationGatewayPort',
    :type      => :integer,
    :context   => :global,
    :obsolete  => true,
    :desc      => 'Obsolete option.'
  },
  {
    :name      => 'UnionStationGatewayCert',
    :type      => :string,
    :context   => :global,
    :obsolete  => true,
    :desc      => 'Obsolete option.'
  },
  {
    :name      => 'UnionStationProxyAddress',
    :type      => :string,
    :context   => :global,
    :obsolete  => true,
    :desc      => 'Obsolete option.'
  },
  {
    :name      => 'PassengerAnalyticsLogUser',
    :type      => :string,
    :context   => :global,
    :obsolete  => true,
    :desc      => 'Obsolete option.'
  },
  {
    :name      => 'PassengerAnalyticsLogGroup',
    :type      => :string,
    :context   => :global,
    :obsolete  => true,
    :desc      => 'Obsolete option.'
  },
  {
    :name      => 'UnionStationKey',
    :type      => :string,
    :obsolete  => true,
    :desc      => 'Obsolete option.'
  },
  {
    :name      => 'UnionStationFilter',
    :type      => :string,
    :context   => :location,
    :obsolete  => true,
    :desc      => 'Obsolete option.'
  },
  {
    :name      => 'UnionStationSupport',
    :type      => :flag,
    :obsolete  => true,
    :desc      => 'Obsolete option.'
  }
]

PhusionPassenger::Apache2::ConfigUtils.initialize!(APACHE2_CONFIGURATION_OPTIONS)
