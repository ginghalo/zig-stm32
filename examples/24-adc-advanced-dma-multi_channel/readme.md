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
|adc1       |   Ch0         |     Input     |   A-0      |
|           |   Ch1         |     Input     |   A-1      |
|           |   Ch2         |     Input     |   A-2      |
|           |   Ch3         |     Input     |   A-3      |
|           |   Ch4         |     Input     |   A-4      |
|           |   Ch5         |     Input     |   A-5      |
|           |   Ch6         |     Input     |   A-6      |
|           |   Ch7         |     Input     |   A-7      |

## Interrupt Usage

|   Interrupt  | Position |
|   :--:       | :--:     |
|   dma1c1     | 006CH    |

## DMA Usage

|No  |  Channel    |   Request    |
|:--:|  :--:       |   :--:       |
|1   |  1          |   ADC1       |
