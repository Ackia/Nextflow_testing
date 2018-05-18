#!/usr/bin/env nextflow
/*
 * pipeline input parameters
 */
params.reads = ""
params.outdir = ""
params.trail = ""

// requires --reads for ENA SUB
if (params.reads == '') {
    exit 1, '--reads is a required paramater for ENA SUB pipeline'
}

// requires --outdir for ENA SUB
if (params.outdir == '') {
    exit 1, '--outdir is a required paramater for ENA SUB pipeline'
}

// requires --trail for ENA SUB
if (params.trail == '') {
    exit 1, '--trail is a required paramater for ENA SUB pipeline'
}

reads_in = Channel
          .fromFilePairs(params.reads + '*_{R1,R2}${params.trail}', size: 2, flat: true)

println """\
         Hybrid Assembly- N F   P I P E L I N E
         ===================================
         reads        : ${reads_in}
         outdir       : ${params.outdir}
         """
         .stripIndent()

reads_md5_pe = Channel
             .fromFilePairs(params.reads + '*_{R1,R2}${params.trail}', size: 2, flat: true)

process md5_checksums {
                      publishDir path: "${paras.outdir}", mode: 'copy'
                      input: set val(id), file(read1), file(read2) from reads_md5_pe

                      output: set val(id), file("${id}_R1${params.trail}.md5")

                      script:
                      """
                      #!/usr/bin/env bash
                      echo $read1 $read2
                      md5sum $read1 > ${id}_R1${params.trail}.md5
                      md5sum $read2 > ${id}_R2${params.trail}.md5
                      """
                      }
