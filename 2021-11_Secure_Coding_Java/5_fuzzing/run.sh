git clone git@github.com:CodeIntelligenceTesting/jazzer.git
cd jazzer
wget --no-check-certificate "https://github.com/bazelbuild/bazelisk/releases/download/v1.10.1/bazelisk-darwin"
./bazelisk-darwin run //examples:ExampleFuzzer

exit
cat <<EOF
Sridhars-MacBook-Air Fri 19 November 2021  7:43PM>                         /Volumes/git/github/training/2021-11_Secure_Coding_Java/5_fuzzing/jazzer
Sridhars-MacBook-Air Fri 19 November 2021  7:43PM> ./bazelisk-darwin run //examples:ExampleFuzzer
Starting local Bazel server and connecting to it...
INFO: Analyzed target //examples:ExampleFuzzer (88 packages loaded, 1890 targets configured).
INFO: Found 1 target...
INFO: From Linking external/com_google_absl/absl/types/libbad_optional_access.a:
warning: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/libtool: archive library: bazel-out/darwin-opt-ST-15fb17c107d0/bin/external/com_google_absl/absl/types/libbad_optional_access.a the table of contents is empty (no object file members in the library define global symbols)
INFO: From Compiling src/raw_logging.cc:
external/com_google_glog/src/raw_logging.cc:139:3: warning: 'syscall' is deprecated: first deprecated in macOS 10.12 - syscall(2) is unsupported; please switch to a supported interface. For SYS_kdebug_trace use kdebug_signpost(). [-Wdeprecated-declarations]
  safe_write(STDERR_FILENO, buffer, strlen(buffer));
  ^
external/com_google_glog/src/raw_logging.cc:63:34: note: expanded from macro 'safe_write'
# define safe_write(fd, s, len)  syscall(SYS_write, fd, s, len)
                                 ^
/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.15.sdk/usr/include/unistd.h:742:6: note: 'syscall' has been explicitly marked deprecated here
int      syscall(int, ...);
         ^
1 warning generated.
INFO: From Compiling src/utilities.cc:
external/com_google_glog/src/utilities.cc:251:17: warning: 'syscall' is deprecated: first deprecated in macOS 10.12 - syscall(2) is unsupported; please switch to a supported interface. For SYS_kdebug_trace use kdebug_signpost(). [-Wdeprecated-declarations]
    pid_t tid = syscall(__NR_gettid);
                ^
/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.15.sdk/usr/include/unistd.h:742:6: note: 'syscall' has been explicitly marked deprecated here
int      syscall(int, ...);
         ^
1 warning generated.
INFO: From KotlinCompile //agent/src/main/java/com/code_intelligence/jazzer/runtime:runtime { kt: 2, java: 10, srcjars: 0 } for darwin:
agent/src/main/java/com/code_intelligence/jazzer/runtime/SignalHandler.java:17: warning: Signal is internal proprietary API and may be removed in a future release
import sun.misc.Signal;
               ^
agent/src/main/java/com/code_intelligence/jazzer/runtime/SignalHandler.java:24: warning: Signal is internal proprietary API and may be removed in a future release
    Signal.handle(new Signal("INT"), sig -> handleInterrupt());
                      ^
agent/src/main/java/com/code_intelligence/jazzer/runtime/SignalHandler.java:24: warning: Signal is internal proprietary API and may be removed in a future release
    Signal.handle(new Signal("INT"), sig -> handleInterrupt());
    ^
warning: Signal is internal proprietary API and may be removed in a future release
4 warnings
INFO: From jarjar //agent:jazzer_agent_deploy:
Fully-qualified classname does not match jar entry:
  jar entry: META-INF/versions/9/module-info.class
  class name: module-info.class
Omitting META-INF/versions/9/module-info.class.
Fully-qualified classname does not match jar entry:
  jar entry: META-INF/versions/9/kotlin/reflect/jvm/internal/impl/serialization/deserialization/builtins/BuiltInsResourceLoader.class
  class name: kotlin/reflect/jvm/internal/impl/serialization/deserialization/builtins/BuiltInsResourceLoader.class
Omitting META-INF/versions/9/kotlin/reflect/jvm/internal/impl/serialization/deserialization/builtins/BuiltInsResourceLoader.class.
Target //examples:ExampleFuzzer up-to-date:
  bazel-bin/examples/ExampleFuzzer.jar
  bazel-bin/examples/ExampleFuzzer
INFO: Elapsed time: 253.004s, Critical Path: 93.92s
INFO: 212 processes: 50 internal, 139 darwin-sandbox, 23 worker.
INFO: Build completed successfully, 212 total actions
INFO: Running command line: external/bazel_tools/tools/test/test-setup.sh examples/ExampleFuzzer driver/jazzer_driver examples/ExampleFuzzer_target_deploy.INFO: Build completed successfully, 212 total actions
exec ${PAGER:-/usr/bin/less} "$0" || exit 1
Executing tests from //examples:ExampleFuzzer
-----------------------------------------------------------------------------
INFO: Loaded 1 hooks from com.example.ExampleFuzzerHooks
INFO: Loaded 8 hooks from com.code_intelligence.jazzer.sanitizers.Deserialization
INFO: Loaded 1 hooks from com.code_intelligence.jazzer.sanitizers.ReflectiveCall
INFO: Loaded 3 hooks from com.code_intelligence.jazzer.sanitizers.ExpressionLanguageInjection
INFO: Instrumented com.example.ExampleFuzzer (took 214 ms, size +81%)
INFO: libFuzzer ignores flags that start with '--'
INFO: Running with entropic power schedule (0xFF, 100).
INFO: Seed: 2735196724
INFO: Loaded 1 modules   (512 inline 8-bit counters): 512 [0x7fa990be5000, 0x7fa990be5200),
INFO: Loaded 1 PC tables (512 PCs): 512 [0x7fa9910e5000,0x7fa9910e7000),
INFO: -max_len is not provided; libFuzzer will not generate inputs larger than 4096 bytes
INFO: A corpus is not provided, starting from an empty corpus
#2	INITED cov: 4 ft: 4 corp: 1/1b exec/s: 0 rss: 94Mb
#1213	NEW    cov: 5 ft: 5 corp: 2/14b lim: 14 exec/s: 0 rss: 97Mb L: 13/13 MS: 1 CMP- DE: "magicstring4"-
#1342	REDUCE cov: 5 ft: 5 corp: 2/13b lim: 14 exec/s: 0 rss: 97Mb L: 12/12 MS: 4 ChangeBit-ChangeBinInt-CMP-EraseBytes- DE: "magicstring4"-
#5746	NEW    cov: 7 ft: 7 corp: 3/48b lim: 53 exec/s: 0 rss: 107Mb L: 35/35 MS: 4 InsertByte-InsertRepeatedBytes-ShuffleBytes-CMP- DE: "magicstring4"-
#5807	REDUCE cov: 7 ft: 7 corp: 3/47b lim: 53 exec/s: 0 rss: 108Mb L: 34/34 MS: 1 EraseBytes-
#6741	REDUCE cov: 7 ft: 7 corp: 3/44b lim: 58 exec/s: 0 rss: 110Mb L: 31/31 MS: 4 CopyPart-InsertByte-ChangeByte-EraseBytes-

== Java Exception: com.code_intelligence.jazzer.api.FuzzerSecurityIssueMedium: mustNeverBeCalled has been called
	at com.example.ExampleFuzzer.mustNeverBeCalled(ExampleFuzzer.java:38)
	at com.example.ExampleFuzzer.fuzzerTestOneInput(ExampleFuzzer.java:33)
DEDUP_TOKEN: 4ae75df99cabb92d
== libFuzzer crashing input ==
MS: 4 InsertByte-CMP-ChangeBit-InsertRepeatedBytes- DE: "magicstring4"-; base unit: 187e19f1afa96c617e954c7dd56765153cd59cb8
0x6d,0x61,0x67,0x69,0x63,0x73,0x74,0x72,0x69,0x6e,0x67,0x34,0x0,0x0,0x69,0x63,0x43,0x43,0x43,0x43,0x43,0x43,0x43,0x43,0x43,0x43,0x43,0x43,0x43,0x43,0x43,0x43,0x43,0x43,0x43,0x43,0x43,0x43,0x43,0x43,0x43,0x43,0x43,0x43,0x43,0x43,0x43,0x43,0x43,0x43,0x43,0x43,0x43,0x43,0x43,0x43,0x43,0x43,0x43,0x43,0x43,0x43,0x43,0x43,0x43,0x43,0x43,0x43,0x43,0x43,0x43,0x43,0x43,0x43,0x73,0x45,0x6d,0x61,0x67,0x69,0x63,0x73,0x74,0x72,0x69,0x6e,0x67,0x34,0x74,0x72,0x69,0x6e,0x67,0x34,0x0,0x0,0x2c,0x0,0x0,0x80,0x31,0xa,
magicstring4\x00\x00icCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCsEmagicstring4tring4\x00\x00,\x00\x00\x801\x0a
artifact_prefix='/private/var/tmp/_bazel_sarnobat/e87397a7ebfaeec1ed3a6a5146402d4c/execroot/jazzer/bazel-out/darwin-opt/testlogs/examples/ExampleFuzzer/test.outputs/'; Test unit written to /private/var/tmp/_bazel_sarnobat/e87397a7ebfaeec1ed3a6a5146402d4c/execroot/jazzer/bazel-out/darwin-opt/testlogs/examples/ExampleFuzzer/test.outputs/crash-3e9b19b722c8a07d6b2336fd22bef13e0b1dc432
Base64: bWFnaWNzdHJpbmc0AABpY0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NzRW1hZ2ljc3RyaW5nNHRyaW5nNAAALAAAgDEK
reproducer_path='/private/var/tmp/_bazel_sarnobat/e87397a7ebfaeec1ed3a6a5146402d4c/execroot/jazzer/bazel-out/darwin-opt/testlogs/examples/ExampleFuzzer/test.outputs'; Java reproducer written to /private/var/tmp/_bazel_sarnobat/e87397a7ebfaeec1ed3a6a5146402d4c/execroot/jazzer/bazel-out/darwin-opt/testlogs/examples/ExampleFuzzer/test.outputs/Crash_3e9b19b722c8a07d6b2336fd22bef13e0b1dc432.java
EOF