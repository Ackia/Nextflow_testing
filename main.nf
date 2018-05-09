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

reads_pe = Channel
  .fromFilePairs(params.reads + '*_{R1, R2}_*.fastq.gz', size: 2, flat: true)
  println()

process list_files {
  input:
  file reads from reads_pe
  output:
  file 'samples' into sample_list
  script:
  """
  echo $reads
  """
}
