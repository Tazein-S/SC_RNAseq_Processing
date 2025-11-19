#!/usr/bin/env nextflow

process BAMTOFASTQ {
    label 'process_medium'
    container 'ghcr.io/bf528/cellranger:latest'
    publishDir params.outdir, mode: 'copy'

    input:
    tuple val(sample), path(bam)

    output:
    tuple val(sample), path("${sample}/**", type: 'dir')

    script:
    """
    cellranger bamtofastq $bam ${sample}/
    """

    stub:
    """
    mkdir -p ${sample}
    """
}