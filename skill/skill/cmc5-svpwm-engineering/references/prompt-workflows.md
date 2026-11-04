# Prompt workflows

使用前将方括号字段替换为当前项目的真实信息。不要把模板中的示例参数当成通用结论。

## 工程双版本审计

~~~text
请审计以下两个 Vivado 工程：
- 基线版：[normal_project_path]
- 实验版：[chaos_project_path]
- 目标器件：[part]
- 预期 Vivado 版本：[version]

先只读取文件，不修改工程。分别列出顶层模块、RTL、XDC、仿真、XPR、BIT、构建脚本、时序报告和资源报告。确认两个版本除预期调制机制外还有哪些差异。对每个结论标注证据来自源码、仿真、实现报告还是实板数据。最后给出缺失项和风险，不要根据 BIT 文件名推断源码版本。
~~~

## 可复现构建

~~~text
请为 [project_path] 建立可复现构建流程。使用 Vivado [version]，目标器件为 [part]。先运行现有仿真，再用批处理方式综合、实现和生成 BIT。保留完整命令、日志、WNS/TNS、DRC、IO 和资源报告。若工程使用绝对路径，改为相对路径或在报告中明确限制。不要烧录硬件。
~~~

## 普通版与混沌版对比

~~~text
请比较 [normal_project_path] 与 [chaos_project_path]。确认电频率、调制度、死区、顶层接口、XDC 和使能逻辑是否一致，然后提取载波策略、LUT、寄存器、BRAM、DSP、WNS、TNS 和 BIT SHA-256。输出一张对比表，并明确混沌调制能证明什么、不能证明什么。
~~~

## 示波器与 FFT 测试规划

~~~text
请为 [signal_name] 制定普通版与混沌版的可比测试流程。仪器为 [oscilloscope_or_analyzer]。固定探头位置、接地方式、采样率、记录长度、时基、频谱跨度、窗函数、RBW、平均次数和幅值单位。先验证时域 PWM，再做 FFT。说明如何避免触发漂移、混叠和平均方式造成两版频谱看起来相同。
~~~

## 电机不转或抖动诊断

~~~text
系统由 [fpga_board]、[driver_board]、[motor]、[bus_voltage] 组成，现象为 [symptom]。当前 PWM 模式是 [3pwm_or_6pwm]，EN/PWM 有效电平证据来自 [manual_or_measurement]。请按“断电检查 -> FPGA 端 PWM -> 驱动输入 -> 驱动输出 -> 电机接线 -> 电源限流”的顺序定位。禁止直接建议持续提高调制度或绕过保护。
~~~

## 竞赛工程包交付

~~~text
请把 [normal_project_path] 和 [chaos_project_path] 整理为可复现工程包。目录名只用英文小写、数字、下划线或连字符。必须包含 README、src、sim、build、board、data、skill 和 report。加入 BIT 哈希、构建命令、验证结论、资源时序对比、实板数据索引和未完成材料清单。不要伪造 GitHub 地址、实测数据或性能提升比例。
~~~
