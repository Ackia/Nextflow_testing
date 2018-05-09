#!/usr/bin/env nextflow

params.reads = ''
params.output = ''

if (params.reads == '') {
  exit 1, '--reads is a required parameter'
}
if (params.output == '') {
  exit 1, '--output is a required paramter'
}

println """\
          Sequencing QC pipeline
          =============================
          reads:  ${params.reads}
          outdir: ${params.output}
          """
          .stripIndent()
