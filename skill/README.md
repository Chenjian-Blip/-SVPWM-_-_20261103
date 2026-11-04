# CMC5 SVPWM engineering skill package

本技能包把混沌化 SVPWM 项目开发中已经验证的经验整理为可重复使用的流程，适用于具有“固定载波基线版 + 混沌变载波版”的 Vivado FPGA 工程。

## 包含内容

- skill/README.md：比赛提交要求的技能包总说明。
- skill/cmc5-svpwm-engineering/SKILL.md：可直接供 Codex 使用的技能入口。
- references/：提示词工作流、案例模板、硬件安全、排错清单、发布检查和真实案例。
- scripts/：工程完整性检查、Vivado 报告对比、SHA-256 清单生成脚本。

## 使用方法

比赛提交时保留整个目录。作为 Codex Skill 使用时，将 skill/cmc5-svpwm-engineering 复制到个人 Codex skills 目录，然后通过 $cmc5-svpwm-engineering 调用。

验证脚本均为只读检查或在用户指定位置生成报告，不会烧录 FPGA，也不会控制电机。

## 已验证范围

脚本和流程已在 AX7020 / XC7Z020CLG400-2 的一组 3 Hz、8% 调制度工程上验证，能够识别 XPR、RTL、XDC、BIT 和实现报告，校验 BIT 哈希，并提取普通版与混沌版的 WNS、TNS、LUT、寄存器、BRAM 和 DSP 数据。

## 失效条件

只有 BIT 而没有源码时，不能还原完整算法与工程；没有实现报告时，不能证明时序收敛；没有实板原始测量数据时，不能宣称电机性能或频谱指标获得提升。
