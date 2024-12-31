# Configuration

## Basic parameter

Using board: Blue pill

Entry symbol: _start

### Memory:

|Type       |   Value    |   Unit   | 
|:--:       |   :--:     |   :--:   |
|stack      |   800H     |   B      |
|heap       |   400H     |   B      |
|flash      |   64       |   kB     |
|ram        |   20       |   kB     |

### Frequency:

PLL source: High Speed Clock (HSE)

|Type       |   Value    |   Unit   | 
|:--:       |   :--:     |   :--:   |
|hse        |   8        |   MHz    |
|sysclk     |   72       |   MHz    |
|pllclk     |   72       |   MHz    |
|hclk       |   72       |   MHz    |
|pclk1      |   36       |   MHz    |
|pclk2      |   72       |   MHz    |


## GPIO Usage

|Peripheral |   Function    |     GPIO Type |   Port-Pin |
|:--:       |   :--:        |     :--:      |   :--:     |
|rcc        |   HSE-OSC-IN  |     Input     |   D-0      |
|           |   HSE-OSC-OUT |     Output    |   D-1      |
|sw-dp      |   SWDIO       |     Input     |   A-13     |
|           |   SWCLK       |     Input     |   A-14     |
|tim2       |   Ch1-PWM1    |     Output    |   A-0      |
|           |   Ch2-PWM1    |     Output    |   A-1      |
|           |   Ch3-PWM1    |     Output    |   A-2      |
|           |   Ch4-PWM1    |     Output    |   A-3      |

## Interrupt Usage

|   Interrupt  | Position |
|   :--:       | :--:     |
|   dma1c2     | 0070H    |

## DMA Usage

|No  |  Channel    |   Request    |
|:--:|  :--:       |   :--:       |
|1   |  2          |   TIM2-UP    |
