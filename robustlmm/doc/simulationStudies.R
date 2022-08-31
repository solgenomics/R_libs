### R code from vignette source 'simulationStudies.Rnw'

###################################################
### code chunk number 1: basic-options
###################################################
options(width=70,
        str=strOptions(strict.width = "wrap", vec.len=2),
        continue = "  ")
require(ggplot2)
theme <- theme_bw(base_size = 9)
theme$legend.position = "top"
theme_set(theme)


###################################################
### code chunk number 2: simulationStudies.Rnw:98-99 (eval = FALSE)
###################################################
## robustlmm::viewCopyOfSimulationStudy("sensitivityCurves.R")


###################################################
### code chunk number 3: simulationStudies.Rnw:112-113 (eval = FALSE)
###################################################
## remotes::install_github("kollerma/robustlmm", "full-results")


###################################################
### code chunk number 4: source-sensitivity-curves-code
###################################################
source(system.file("simulationStudy/sensitivityCurves.R",
                   package = "robustlmm"))


###################################################
### code chunk number 5: plot_scLegend
###################################################
print(plot_shiftFirstObservation)
plot_shiftFirstObservation <- plot_shiftFirstObservation +
    theme(legend.position = "none")
plot_shiftFirstGroup <- plot_shiftFirstGroup +
    theme(legend.position = "none")
plot_scaleFirstGroup <- plot_scaleFirstGroup +
    theme(legend.position = "none")


###################################################
### code chunk number 6: plot_shiftFirstObservation
###################################################
print(plot_shiftFirstObservation)


###################################################
### code chunk number 7: plot_shiftFirstGroup
###################################################
print(plot_shiftFirstGroup)


###################################################
### code chunk number 8: plot_scaleFirstGroup
###################################################
print(plot_scaleFirstGroup)


###################################################
### code chunk number 9: source-consistency-and-efficiency-diagonal-code
###################################################
source(system.file("simulationStudy/consistencyAndEfficiencyDiagonal.R",
                   package = "robustlmm"))


###################################################
### code chunk number 10: plot_consistencyDiagonal
###################################################
print(plot_consistencyDiagonal)


###################################################
### code chunk number 11: plot_efficiencyDiagonal
###################################################
print(plot_efficiencyDiagonal)


###################################################
### code chunk number 12: source-consistency-and-efficiency-block-diagonal-code
###################################################
source(system.file("simulationStudy/consistencyAndEfficiencyBlockDiagonal.R",
                   package = "robustlmm"))


###################################################
### code chunk number 13: plot_consistencyBlockDiagonal
###################################################
print(plot_consistencyBlockDiagonal)


###################################################
### code chunk number 14: plot_efficiencyBlockDiagonal
###################################################
print(plot_efficiencyBlockDiagonal)


###################################################
### code chunk number 15: source-breakdown-code
###################################################
source(system.file("simulationStudy/breakdown.R",
                   package = "robustlmm"))


###################################################
### code chunk number 16: plot_breakdown
###################################################
print(plot_breakdown)


###################################################
### code chunk number 17: source-convergence-code
###################################################
source(system.file("simulationStudy/convergence.R",
                   package = "robustlmm"))


###################################################
### code chunk number 18: plot_convergence_N_N_bias
###################################################
print(plot_convergence_N_N_bias)


###################################################
### code chunk number 19: plot_convergence_N_N_scale
###################################################
print(plot_convergence_N_N_scale)


###################################################
### code chunk number 20: plot_convergence_N_N_efficiency
###################################################
print(plot_convergence_N_N_efficiency)


###################################################
### code chunk number 21: plot_convergence_t3_t3_bias
###################################################
print(plot_convergence_t3_t3_bias)


###################################################
### code chunk number 22: plot_convergence_t3_t3_scale
###################################################
print(plot_convergence_t3_t3_scale)


###################################################
### code chunk number 23: plot_convergence_t3_t3_efficiency
###################################################
print(plot_convergence_t3_t3_efficiency)


###################################################
### code chunk number 24: source-robustness-diagonal-code
###################################################
source(system.file("simulationStudy/robustnessDiagonal.R",
                   package = "robustlmm"))


###################################################
### code chunk number 25: plot_robustnessDiagonal
###################################################
print(plot_robustnessDiagonal)


###################################################
### code chunk number 26: plot_coverageDiagonal
###################################################
print(plot_coverageDiagonal)


###################################################
### code chunk number 27: source-robustness-block-diagonal-code
###################################################
source(system.file("simulationStudy/robustnessBlockDiagonal.R",
                   package = "robustlmm"))


###################################################
### code chunk number 28: plot_robustnessBlockDiagonal
###################################################
print(plot_robustnessBlockDiagonal)


###################################################
### code chunk number 29: plot_violinBlockDiagonal
###################################################
print(plot_violinBlockDiagonal)


###################################################
### code chunk number 30: sessionInfo
###################################################
sub("robustlmm~03.0", "robustlmm~3.0", sub("/Resources", "/|\n\\\\verb|Resources", attr(results, "sessionInfo")))


