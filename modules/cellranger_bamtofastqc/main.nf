#!/usr/bin/env nextflow

process BAMTOFASTQ {
    label 'process_high'
    container 'ghcr.io/bf528/cellranger:latest'
    publishDir params.outdir, mode: 'copy'

    input:
    tuple val(sample), path(bam)

    output:
    tuple val(sample), path("${sample}/")

    script:
    """
    cellranger bamtofastq \
        --nthreads=${task.cpus} \
        $bam \
        ${sample}/
    """

    stub:
    """
    mkdir -p ${sample}
    """
}