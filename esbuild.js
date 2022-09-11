#!/usr/bin/env node
'use strict'

const esbuild = require('esbuild')
const { join: shJoin } = require('shlex')

const isProduction = process.env.NODE_ENV === 'production'

const options = {
  entryPoints: process.argv.slice(2),
  bundle: true,
  sourcemap: true,
  minify: isProduction,
  define: {},
  outdir: 'app/assets/builds',
}

if (process.env.NODE_ENV) {
  options.define['process.env.NODE_ENV'] = JSON.stringify(process.env.NODE_ENV)
} else {
  options.define['process.env.NODE_ENV'] = JSON.stringify('development')
}

function optionsToArgs(options) {
  const args = ['esbuild']
  if (options.bundle) args.push('--bundle')
  if (options.sourcemap) args.push('--sourcemap')
  if (options.minify) args.push('--minify')
  if (options.outdir) args.push(`--outdir=${options.outdir}`)
  if (options.define) {
    for (const [key, value] of Object.entries(options.define)) {
      args.push(`--define:${key}=${value}`)
    }
  }
  if (Array.isArray(options.entryPoints)) {
    args.push(...options.entryPoints)
  }
  return shJoin(args)
}

console.log(`+ ${optionsToArgs(options)}`)

// "info" is the default log level for CLI usage, which we emulate.
options.logLevel = 'info'
esbuild.buildSync(options)
