import * as React from 'react'
import {useState} from 'react'
import {clsx} from 'clsx'

import Select from 'components/Select'
import type {SelectItem} from 'components/Select'

const countryCode = [
  {id: 0, label: '+1'},
  {id: 1, label: '+93'},
]

export default function MobileNumber(): JSX.Element {
  const [code, setCode] = useState(0)
  const [phone, setPhone] = useState<string | null>(null)

  const onPhoneInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setPhone(e.target.value)
  }

  return (
    <div className="grid grid-cols-4 gap-4">
      <div>
        <Select
          id="year"
          className="mt-4"
          label=""
          labelInvisible={true}
          items={countryCode}
          value={code}
          onSelect={(selected: SelectItem, i: number) => setCode(i)}
        />
      </div>
      <div className="col-span-2">
        <span className="flex">
          <input
            type="tel"
            name="phone-number"
            id="phone-number"
            className={clsx('base-input grow mt-4 rounded-md border-gray-300 shadow-sm sm:text-sm flex-1')}
            placeholder="(XXX) XXX - XXXX"
            onChange={onPhoneInputChange}
            value={phone}
          />
        </span>
      </div>
    </div>
  )
}
