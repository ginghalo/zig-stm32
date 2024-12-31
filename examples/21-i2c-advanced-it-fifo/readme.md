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
|i2c1       |   SCL         |     Output    |   B-6      |
|           |   SDA         |     Output    |   B-7      |

## Interrupt Usage

|   Interrupt  | Position |
|   :--:       | :--:     |
|   i2c1_ev    | 00BCH    |

## DMA Usage

|No  |  Channel    |   Request    |
|:--:|  :--:       |   :--:       |
|    |             |              |
