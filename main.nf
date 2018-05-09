#!/usr/bin/env nextflow

params.reads = '~/Nextflow_QC_work/MiniSeq_Nextera_DNA_Flex_replicates_of_E.coli_B.cereus_and_R.sphaeroides_-48128083/FASTQ_Generation_2017-09-21_21_17_08Z-55066256/ds.304e6afab9524e32b27c836ed1221321/'
params.output = '/data/output'

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

Channel
  .fromFilePairs(params.reads + '*_{R1, R2}_*.fastq.gz', size: 2, flat: true)
  .println()

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
