require 'mkmf'

$CFLAGS << ' -std=c99 -Wall -Werror -pedantic -ObjC'
$LIBS   << ' -framework CoreFoundation -framework ApplicationServices -framework Cocoa'
$LIBS   << ' -framework CoreGraphics' unless `sw_vers -productVersion`.to_f == 10.7

unless RbConfig::CONFIG["CC"].match(/clang/)
  clang = `which clang`.chomp
  if clang.empty?
    raise "Clang not installed. Cannot build C extension"
  else
    RbConfig::MAKEFILE_CONFIG["CC"]  = clang
    RbConfig::MAKEFILE_CONFIG["CXX"] = clang
  end
end

create_makefile 'accessibility/bridge/bridge'
