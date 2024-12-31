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
|gpio       |   8SEG-A      |     Output    |   A-0      |
|           |   8SEG-B      |     Output    |   A-1      |
|           |   8SEG-C      |     Output    |   A-2      |
|           |   8SEG-D      |     Output    |   A-3      |
|           |   8SEG-E      |     Output    |   A-4      |
|           |   8SEG-F      |     Output    |   A-5      |
|           |   8SEG-G      |     Output    |   A-6      |
|           |   8SEG-DP     |     Output    |   A-7      |
|           |   8SEG-EN     |     Output    |   A-8      |

## Interrupt Usage

|   Interrupt  | Position |
|   :--:       | :--:     |
|              |          |

## DMA Usage

|No  |  Channel    |   Request    |
|:--:|  :--:       |   :--:       |
|    |             |              |
