#!/usr/bin/env python
import os
import sys

GodotVersion = 4.2
ProjectName = 'SpaceShooter'
OutputFolder = f'{ProjectName}/bin'

env = SConscript('godot-cpp/SConstruct')

platform = env['platform']
target = env['target']
arch = env['arch']

supportedPlatforms = [
    'windows',
    'linux',
]

supportedTargets = [
    'template_debug',
    'template_release',
]

supportedArchetectures = [
    'x86_64',
]

def createExtensionFile(name, libName, entrySymbol):
    
    file = open(f'{OutputFolder}/{name}.gdextension', 'w')
    file.write('[configuration]\n\n')

    file.write(f'entry_symbol = "{entrySymbol}"\n')
    file.write(f'compatibility_minimum = {GodotVersion}\n\n')

    file.write('[libraries]\n\n')

    libTargetNames = ['debug', 'release']
    libExtensions = ['dll', 'so']

    platIdx = 0
    for platName in supportedPlatforms:
        for archName in supportedArchetectures:
            targetIdx = 0
            for targetName in supportedTargets:
                libTarget = f'{platName}.{libTargetNames[targetIdx]}'
                resPath = f'res://bin/{libName}.{platName}.{targetName}.{archName}.{libExtensions[platIdx]}'
                file.write(f'{libTarget} = "{resPath}"\n')
                targetIdx += 1
        platIdx += 1
    file.close()

def buildGDExtensionLib(name, entrySymbol, sources):

    if not isinstance(name, str):
        raise ValueError('Attempting to build a library with an invalid name', libName)

    libName = f'lib{name}'
    suffix = env['suffix']
    libSuffix = env['SHLIBSUFFIX']

    libOut = f'{OutputFolder}/{libName}{suffix}{libSuffix}'

    createExtensionFile(name, libName, entrySymbol)

    return env.SharedLibrary(libOut, source=sources)

if platform not in supportedPlatforms:
    raise UserError(f'Unsupported platform: {platform}, supported platforms: {supportedPlatforms}')

if target not in supportedTargets:
    raise UserError(f'Unsupported target: {target}, supported targets: {supportedTargets}')

if arch not in supportedArchetectures:
    raise UserError(f'Unsupported archetecture: {arch}, supported archetectures: {supportedArchetectures}')

libs = []

#gdexampleSources = Glob('src/gdexample/*.cpp')
#libs.append(buildGDExtensionLib('gdexample', 'example_library_init', gdexampleSources))

Default(libs)