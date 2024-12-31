# Coding style guide

There's the coding style guide that I use it to write code in my project. Wishing it'll help you understand my code. 

## use under_score_case style to write code

```zig
const hello_world = "Hello world!";
```

## first case of defined type must be bigcase, unless it's in function body

For examples, the value `context` that would be used in compile time have the type name called `Context`

```zig
pub const Context = struct{};
```

## function's first case depends on its return type and position

When it return the type of `type` and top position, it's first case must be bigcase, or it's first case must be smallcase

```zig
// sth.zig
pub fn Return_type() type{
    return struct{
        pub fn return_this()type{
            return @This();
        }
    };
}
fn return_other() Context{
    return Return_type(){};
}
```

## block label's name must be bigcase at all

```zig
const u1_1:u1 = U1_1:{
    break :U1_1 @as(u1,1);
};
```

## all thing that is exposed must not have prefix and suffix '_'

To avoid meeting name confliction, I sometimes use prefix and suffix '_', but whenever I expose thing, I would not use these.

```zig
pub const uart = UART: {
    const __block_uart__ = @import("uart.zig");
    break :UART __block_uart__;
}
```

## function's parameter name must have a prefix '_'

For examples, the `get` function from GPIOA.PIN13. The function need comptime parameter `context` with type `Context` and return the value with type `u1`.

The structure of that is like:

```zig
pub fn get(comptime _context:Context) u1{
    // function body
}
```

## variable and constant value's name in function body must be small case at all

Following the function `get`, I define the variable call `value` with initial value `0`, which will be return in the end of function;

```zig
    var value:u1 = 0;
    // get pin's level and assign it to `value`
    return value;
```

## not avoid using the number name 

If the variable name is number, it is number.

For examples, in ADC part, there has two of them in stm32f103c, so I write it like that:

```zig
/// adc.zig
pub const @"1" = Adc(No.@"1");
pub const @"2" = Adc(No.@"2");
```

## avoid using the standard library without understanding its costs

It's the mcu project with little hardware resource without operating system, so avoid using **propably-huge-costing** and the **os builtin** function in there.

However, it'is not forbidden for using standard library. When the costs of function or something else in std is under control, just use it.

## avoid using abbreviation, unless it's commen sense (in my notion)

Like ct(compile time), ctx(context), mcu(microcontroller unit), freq(frequency) and any abbreviation in stm32.
