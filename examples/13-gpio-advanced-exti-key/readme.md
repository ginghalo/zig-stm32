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
|gpio       |   KEY-R1      |     Output    |   A-15     |
|           |   KEY-R2      |     Output    |   B-3      |
|           |   KEY-R3      |     Output    |   B-4      |
|           |   KEY-R4      |     Output    |   B-5      |
|           |   KEY-C1      |     Input     |   B-9      |
|           |   KEY-C2      |     Input     |   B-8      |
|           |   KEY-C3      |     Input     |   B-7      |
|           |   KEY-C4      |     Input     |   B-6      |
|           |   KEY-SINGLE  |     Input     |   A-0      |

## Interrupt Usage

|   Interrupt  | Position |
|   :--:       | :--:     |
|   exti9_5    | 009CH    |

## DMA Usage

|No  |  Channel    |   Request    |
|:--:|  :--:       |   :--:       |
|    |             |              |
