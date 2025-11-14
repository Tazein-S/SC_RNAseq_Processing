#!/usr/bin/env nextflow

process BAMTOFASTQ {
    label 'process_high'
    container 'ghcr.io/bf528/cellranger:latest'
    publishDir params.outdir, mode: 'copy'

    input:
    tuple val(sample), path(bam)

    output:
    tuple val(sample), path("${sample}_fastqs"), emit: fastqs

    script:
    """
    cellranger bamtofastq \\
        --nthreads=${task.cpus} \\
        ${bam} \\
        ${sample}_fastqs
    """

    stub:
    """
    mkdir -p ${sample}_fastqs
    touch ${sample}_fastqs/${sample}_R1.fastq.gz
    touch ${sample}_fastqs/${sample}_R2.fastq.gz
    """
}