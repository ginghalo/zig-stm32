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
|spi1       |   SCLK        |     Output    |   A-5      |
|           |   MISO        |     Input     |   A-6      |
|           |   MOSI        |     Output    |   A-7      |
|spi2       |   SCLK        |     Output    |   B-13     |
|           |   MISO        |     Input     |   B-14     |
|           |   MOSI        |     Output    |   B-15     |
|           |   NSS         |     Output    |   B-12     |
|gpio       |   SPI1-NSS    |     Output    |   A-4      |

## Interrupt Usage

|   Interrupt  | Position |
|   :--:       | :--:     |
|              |          |

## DMA Usage

|No  |  Channel    |   Request    |
|:--:|  :--:       |   :--:       |
|    |             |              |
